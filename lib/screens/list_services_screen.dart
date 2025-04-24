import 'package:demo1/Models/store_service_model.dart';
import 'package:demo1/firebase/store_firebase.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class ListServicesScreen extends StatefulWidget {
  const ListServicesScreen({super.key});

  @override
  State<ListServicesScreen> createState() => _ListServicesScreenState();
}

class _ListServicesScreenState extends State<ListServicesScreen> {
  String selectedStatus= 'Todos';
  StoreFirebase? storeFirebase;

  @override
  void initState(){
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
        title: Text('Gestion de ventas'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/calendarService');
            }, 
            icon: Icon(Icons.calendar_month_rounded)),
            SizedBox(width: 8,)
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: DropdownButtonFormField<String>(
              value: selectedStatus,
              items: [
                DropdownMenuItem(value:'Todos', child:Text('Todos',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)),
                DropdownMenuItem(value:'pendiente', child:Text('Pendiente',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 16))),
                DropdownMenuItem(value:'completado', child:Text('Completado',style: TextStyle(color: Colors.green[800],fontWeight: FontWeight.bold,fontSize: 16))),
                DropdownMenuItem(value:'cancelado', child:Text('Cancelado',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16)))
              ], 
              onChanged: (value){
                setState(() {
                  selectedStatus = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Estado del pedido',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),  
              
            )
            ),
            Expanded(
            child: StreamBuilder(
              stream: storeFirebase!.selectByEstadoRaw(selectedStatus), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No hay pedidos'));
                }

                final pedidos = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: pedidos.length,
                  itemBuilder: (context, index) {
                    var obj = pedidos[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _getColorPorEstado(obj.get('estado')),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("NO. PEDIDO: ${obj.get('id')}", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("CLIENTE: ${obj.get('cliente')}"),
                          SizedBox(height: 8),
                          Text("PRODUCTO: ${obj.get('producto')}"),
                          SizedBox(height: 4),
                          Text("FECHA: ${_formatearFecha(obj.get('fechaServicio'))}",style: TextStyle(fontSize: 12, color: Colors.grey[600]),),
                        ],
                      ),
                    );
                  },
                );
              },
              ),
            )
        ],
      ),

    );
  }
}