import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo1/firebase/store_firebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModalCalendar extends StatelessWidget {
final DateTime date;
final StoreFirebase storeFirebase;

const ModalCalendar({super.key, required this.date, required this.storeFirebase});

  String _formatearFecha(dynamic fecha) {
    if (fecha is Timestamp) {
      final DateTime dateTime = fecha.toDate();
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
    return '-';
  }

  Color _getColorPorEstado(String estado) {
    switch (estado.toLowerCase()) {
      case 'pendiente':
        return Colors.yellow.shade100;
      case 'completado':
        return Colors.green.shade100;
      case 'cancelado':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    DateTime normalizedDate = DateTime.utc(date.year, date.month, date.day);
    
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF1EFEC),
      ),
      child: FutureBuilder<QuerySnapshot>(
        future: storeFirebase.getPedidosFecha(normalizedDate), 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay eventos para este día'));
          }

          final pedidos = snapshot.data!.docs;

          return IgnorePointer(
            ignoring: true,
            child: CustomScrollView(
              slivers:[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text('Pedidos del ${DateFormat('dd/MM/yyyy').format(date)}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context,index){
                    final obj = pedidos[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getColorPorEstado(obj.get('estado')),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("NO. PEDIDO: ${obj.get('id')}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                            Text("CLIENTE: ${obj.get('cliente')}",style: TextStyle(fontSize: 16, color: Colors.black),),
                            SizedBox(height: 4),
                            Text("PRODUCTO: ${obj.get('producto')}",style: TextStyle(fontSize: 16, color: Colors.black),),
                            SizedBox(height: 4),
                            Text("FECHA: ${_formatearFecha(obj.get('fechaServicio'))}",style:TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                      ),
                    );
                  },
                  childCount: pedidos.length
                  )
                )
            
              ]
            ),
          );
        }
      )
    );
  }
}