import 'package:adaptive_dialog/adaptive_dialog.dart';
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
        color: Color(0xFFFFFFFF),
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

          return CustomScrollView(
            slivers:[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text('Pedidos del ${DateFormat('dd/MM/yyyy').format(date)}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black, decoration: TextDecoration.none),),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context,index){
                  final obj = pedidos[index];
                  final estado = obj.get('estado') ?? '';

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
                          Row(
                          children: [
                            Text("No. pedido: PED-${obj.id.substring(obj.id.length - 5)}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black,decoration: TextDecoration.none)),
                            Spacer(),
                            Text("Estado: ${obj.get('estado')}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black87,decoration: TextDecoration.none)),
                          ]
                        ),
                        Row(
                            children: [
                              Text("Fecha: ${_formatearFecha(obj.get('fechaServicio'))}",style:TextStyle( color: Colors.grey[600], fontWeight: FontWeight.bold,fontSize: 15,decoration: TextDecoration.none)),
                              if(estado == 'pendiente')...[
                                Spacer(),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () async{
                                    final result = await showOkCancelAlertDialog(
                                      context: context,
                                      title: 'Cancelar ',
                                      message: 'Estas seguro, cancelar el pedido ?',
                                    );
                                    if(result == OkCancelResult.ok){
                                      await storeFirebase.actualizarEstadoPedido(obj.id, 'cancelado');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Pedido cancelado exitosamente! ')),
                                      );
                                    }
                                  }, 
                                  icon: Icon(Icons.close)
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () async{
                                    final result = await showOkCancelAlertDialog(
                                      context: context,
                                      title: 'Completar ' ,
                                      message: 'Estas seguro, completar el pedido ?'
                                    );
                                    if(result == OkCancelResult.ok){
                                      await storeFirebase.actualizarEstadoPedido(obj.id, 'completado');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Pedido completado exitosamente! :)')),
                                      );

                                    }
                                     
                                  }, 
                                  icon: Icon(Icons.check)
                                ),
                              ],
                            ],
                          ),                          Text("Cliente: ${obj.get('cliente')}",style: TextStyle(fontSize: 15, color: Colors.black,decoration: TextDecoration.none),),
                          SizedBox(height: 4),
                          Builder(
                          builder: (context){
                            final productosList = List<Map<String, dynamic>>.from(obj.get('producto') ?? []);
          
          
                            final productosTexto = productosList.map((producto) {
                            final cantidad = producto['cantidad'] ?? 1;
                            final nombre = producto['nombre'] ?? '';
                              return "$cantidad x $nombre";
                            }).join('\n');
                            return Text("Productos: \n$productosTexto",style: TextStyle(fontSize: 13,decoration: TextDecoration.none,color: Colors.black),);
                          }
                        ),
                        ],
                    ),
                  );
                },
                childCount: pedidos.length
                )
              )
          
            ]
          );
        }
      )
    );
  }
}