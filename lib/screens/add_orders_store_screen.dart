import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo1/firebase/categories_firebase.dart';
import 'package:demo1/firebase/product_firebase.dart';
import 'package:badges/badges.dart' as badges;
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:demo1/firebase/store_firebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddOrdersStoreScreen extends StatefulWidget {
  const AddOrdersStoreScreen({super.key});

  @override
  State<AddOrdersStoreScreen> createState() => _AddOrdersStoreScreenState();
}

class _AddOrdersStoreScreenState extends State<AddOrdersStoreScreen> {
  CategoriesFirebase? categoriesFirebase;
  ProductStoreFirebase? productStoreFirebase;
  StoreFirebase? storeFirebase;
  DateTime? selectedDate;

  String? selectedCategoryId;
  List<Map<String, dynamic>> productosSeleccionados = [];

  @override
  void initState() {
    super.initState();
    productStoreFirebase = ProductStoreFirebase();
    categoriesFirebase = CategoriesFirebase();
    storeFirebase = StoreFirebase();
  }

  Stream<QuerySnapshot>? _getProductsStream() {
      if (selectedCategoryId == null || selectedCategoryId == 'Todos') {
    return productStoreFirebase?.selectProducts();
  } else {
    return FirebaseFirestore.instance
        .collection('products')
        .where('idCategoria', isEqualTo: selectedCategoryId) 
        .snapshots();
  }
  }

  Future<List<Map<String, dynamic>>?> _getCategories() async {
    final categories = await categoriesFirebase?.getCategoriesList();
    return categories;
  }

  void _agregarProductoAlPedido(Map<String, dynamic> producto) {
    setState(() {
      final existing = productosSeleccionados.indexWhere((p) => p['id'] == producto['id']);
      if (existing != -1) {
        productosSeleccionados[existing]['cantidad'] += 1;
      } else {
        productosSeleccionados.add({...producto, 'cantidad': 1});
      }
    });
  }

  void _quitarProductoDelPedido(Map<String, dynamic> producto) {
    setState(() {
      final existing = productosSeleccionados.indexWhere((p) => p['id'] == producto['id']);
      if (existing != -1) {
        if (productosSeleccionados[existing]['cantidad'] > 1) {
          productosSeleccionados[existing]['cantidad'] -= 1;
        } else {
          productosSeleccionados.removeAt(existing);
        }
      }
    });
  }

  int _cantidadProducto(String idProducto) {
    final existing = productosSeleccionados.indexWhere((p) => p['id'] == idProducto);
    if (existing != -1) return productosSeleccionados[existing]['cantidad'];
    return 0;
  }

  void _modalCarrito() {
    final TextEditingController clienteController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF1EFEC),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Detalles del pedido', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (productosSeleccionados.isEmpty)
                const Text('No has agregado productos.')
              else
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: productosSeleccionados.length,
                    itemBuilder: (context, index) {
                      final producto = productosSeleccionados[index];
                      return ListTile(
                        title: Text('${producto['cantidad']}x ${producto['nombre']}'),
                        subtitle: Text(producto['descripcion']),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 12),
              TextField(
                controller: clienteController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del cliente',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Fecha servicio',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: selectedDate != null ? DateFormat('dd/MM/yyyy').format(selectedDate!) : '',
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        productosSeleccionados.clear();
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar Pedido'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (clienteController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Debes ingresar el nombre del cliente')),
                        );
                        return;
                      }
                      if (productosSeleccionados.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No hay productos para guardar')),
                        );
                        return;
                      }
                      await storeFirebase?.addOrder({
                        'cliente': clienteController.text,
                        'producto': productosSeleccionados,
                        'fechaServicio': Timestamp.fromDate(selectedDate!),
                        'estado': 'pendiente',
                      });

                      setState(() {
                        productosSeleccionados.clear();
                      });

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pedido agregado exitosamente!')),
                      );
                    },
                    child: const Text('Confirmar Pedido'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar pedido'),
        actions: [
          badges.Badge(
            badgeContent: Text('${productosSeleccionados.length}', style: const TextStyle(fontSize: 10, color: Colors.white)),
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            child: IconButton(
              onPressed: _modalCarrito,
              icon: const Icon(Icons.shopping_cart_rounded),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<List<Map<String, dynamic>>?>(
            future: _getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: LinearProgressIndicator(),
                );
              }

              final categories = snapshot.data ?? [];

              return Padding(
                padding: const EdgeInsets.all(16),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Filtro por categoria',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedCategoryId ?? 'Todos',
                  items: [
                    const DropdownMenuItem(value: 'Todos', child: Text('Todas las categorias')),
                    ...categories.map((cat) {
                      return DropdownMenuItem(value: cat['id'].toString(), child: Text(cat['nombre']));
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                  },
                ),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getProductsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No hay productos disponibles.'));
                }

                final productos = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    return ListTile(
                      title: Text(producto['nombre']),
                      subtitle: Text(producto['descripcion']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _quitarProductoDelPedido({
                                'nombre': producto['nombre'],
                                'descripcion': producto['descripcion'],
                                'id': producto.id,
                              });
                            },
                            icon: Icon(Icons.remove_circle_outline, color: Colors.red[400], size: 30),
                          ),
                          Text(
                            _cantidadProducto(producto.id).toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            onPressed: () {
                              _agregarProductoAlPedido({
                                'nombre': producto['nombre'],
                                'descripcion': producto['descripcion'],
                                'id': producto.id,
                              });
                            },
                            icon: Icon(Icons.add_circle_outline, color: Colors.blue[400], size: 30),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
