import 'package:demo1/firebase/store_firebase.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class ListServicesScreen extends StatefulWidget {
  const ListServicesScreen({super.key});

  @override
  State<ListServicesScreen> createState() => _ListServicesScreenState();
}

class _ListServicesScreenState extends State<ListServicesScreen> {
  String selectedStatus = 'Todos';
  StoreFirebase? storeFirebase;
  int cantidadProductos = 10;

  @override
  void initState() {
    super.initState();
    storeFirebase = StoreFirebase();
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

  String _formatearFecha(dynamic fecha) {
    if (fecha is Timestamp) {
      final DateTime dateTime = fecha.toDate();
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
    return '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de ventas',style: TextStyle(fontSize: 20),),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calendarService');
              },
              icon: Icon(Icons.calendar_month_rounded)),
          SizedBox(width: 3),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/addOrders');
            }, 
            icon: Icon(Icons.add,size: 30,)
          )
          // badges.Badge(
          //   position: badges.BadgePosition.topEnd(top: 0,end: 3),
          //   badgeContent: Text(cantidadProductos.toString(),style: TextStyle(color: Colors.white,fontSize: 8),),
          //   child: IconButton(
          //     onPressed: (){
          //       Navigator.pushNamed(context, '/shoppingCart');
          //     }, 
          //     icon: Icon(Icons.shopping_cart_rounded)
          //   ),
          // ),
        ],
      ),
      body: StreamBuilder(
        stream: storeFirebase!.selectByEstadoRaw(selectedStatus),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay pedidos'));
          }

          final pedidos = snapshot.data!.docs;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: DropdownButtonFormField<String>(
                    value: selectedStatus,
                    items: [
                      DropdownMenuItem(value: 'Todos',child: Text('Todos',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16))),
                      DropdownMenuItem(value: 'pendiente',child: Text('Pendiente',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 16))),
                      DropdownMenuItem(value: 'completado',child: Text('Completado',style: TextStyle(color: Colors.green[800],fontWeight: FontWeight.bold,fontSize: 16))),
                      DropdownMenuItem(value: 'cancelado',child: Text('Cancelado',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Estado del pedido',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var obj = pedidos[index];
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
                            Text("No. pedido: ${obj.get('id')}",style: TextStyle(fontWeight: FontWeight.bold)),
                            Spacer(),
                            Text("Estado: ${obj.get('estado')}",style: TextStyle(fontWeight: FontWeight.bold)),
                            ]
                          ),
                          Row(
                            children: [
                              Text("Fecha: ${_formatearFecha(obj.get('fechaServicio'))}",style:TextStyle( color: Colors.grey[600], fontWeight: FontWeight.bold)),
                              if(estado == 'pendiente')...[
                                Spacer(),
                                // IconButton(
                                //   padding: EdgeInsets.zero,
                                //   constraints: BoxConstraints(),
                                //   onPressed: (){
                                
                                //   }, 
                                //   icon: Icon(Icons.edit)
                                // ), 
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
                                      await storeFirebase!.actualizarEstadoPedido(obj.id, 'cancelado');
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
                                      await storeFirebase!.actualizarEstadoPedido(obj.id, 'completado');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Pedido completado exitosamente! :)')),
                                      );

                                    }
                                     
                                  }, 
                                  icon: Icon(Icons.check)
                                ),
                              ],
                            ],
                          ),
                          Text("Cliente: ${obj.get('cliente')}",style: TextStyle(fontSize: 15),),
                          SizedBox(height: 8),
                          Text("Productos: ${obj.get('producto')}"),
                          SizedBox(height: 4),
                        ],
                      ),
                    );
                  },
                  childCount: pedidos.length,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.fan,
        overlayStyle: ExpandableFabOverlayStyle(
          blur: 5,
          color: Colors.white10   
        ),
        distance: 70,
        children: [
          FloatingActionButton.small(
          heroTag: 'producto',
          tooltip: 'Agregar Producto',
          child: Icon(Icons.shopping_bag, size: 30,),
          onPressed: () {
              Navigator.pushNamed(context, '/productStore');

            },
          ),
          FloatingActionButton.small(
            heroTag: 'categoria',
            tooltip: 'Agregar Categoría',
            child: Icon(Icons.category,size: 30,),
            onPressed: () {
              Navigator.pushNamed(context, '/categories');
            },
          ),
        ],
      ),
    );
  }
}
