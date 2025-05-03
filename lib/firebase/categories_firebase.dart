import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesFirebase {
final firebase = FirebaseFirestore.instance;
  CollectionReference? collection;

  CategoriesFirebase(){
    collection = firebase.collection('categories');
  }


  Stream<QuerySnapshot> selectCategories() {
    return collection!.snapshots();
  }

  Future<void> addCategory(Map<String, dynamic> category) async {
    await collection!.add(category);
  }

  Future<void> updateCategory(String id, Map<String, dynamic> data) async {
    await collection!.doc(id).update(data);
  }

  Future<void> deleteCategory(String id) async {
    await collection!.doc(id).delete();
  }

  Future<List<Map<String, dynamic>>> getCategoriesList() async {
  final snapshot = await collection!.get();
  return snapshot.docs.map((doc) {
    return {
      'id': doc.id,
      'nombre': doc['nombre'],
    };
  }).toList();
}

}