import 'package:cloud_firestore/cloud_firestore.dart';

class StoreFirebase {
final firebase = FirebaseFirestore.instance;
  CollectionReference? collection;

  StoreFirebase(){
    collection = firebase.collection('store');
  }

  Stream<QuerySnapshot> selectByEstadoRaw(String estado) {
    if (estado == "Todos") {
      return collection!.snapshots();
    }

    return collection!.where('estado', isEqualTo: estado).snapshots();
  }

  Future<void> addOrder(Map<String, dynamic> store) async{
    await collection!.doc().set(store);
  }

  Future<void> updateOrder(Map<String, dynamic> store, String id) async{
    await collection!.doc(id).set(store);
  }
  
  Future<void> deleteOrder( String id) async{
    await collection!.doc(id).delete();
  }


  Future<Map<DateTime, List<String>>> getEventosCalendar() async {
    final snapshot = await collection!.get();
    Map<DateTime, List<String>> resultado = {};

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;

      if (data.containsKey('fechaServicio') && data.containsKey('estado')) {
        final Timestamp ts = data['fechaServicio'];
        final estado = data['estado'] as String;

        final fecha = DateTime.utc(
          ts.toDate().year,
          ts.toDate().month,
          ts.toDate().day,
        );

        resultado.putIfAbsent(fecha, () => []);
        resultado[fecha]!.add(estado.toLowerCase());
      }
    }

    return resultado;
  }


  Future<QuerySnapshot> getPedidosFecha(DateTime fecha) async {
  final inicioDia = Timestamp.fromDate(DateTime.utc(fecha.year, fecha.month, fecha.day, 0, 0, 0));
  final finDia = Timestamp.fromDate(DateTime.utc(fecha.year, fecha.month, fecha.day, 23, 59, 59));

  return await collection!
      .where('fechaServicio', isGreaterThanOrEqualTo: inicioDia)
      .where('fechaServicio', isLessThanOrEqualTo: finDia)
      .get();
}

Future<void> actualizarEstadoPedido(String docId, String nuevoEstado) async {
  await collection!.doc(docId).update({
    'estado': nuevoEstado,
  });
}


}