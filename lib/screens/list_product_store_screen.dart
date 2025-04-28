import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo1/firebase/categories_firebase.dart';
import 'package:demo1/firebase/product_firebase.dart';
import 'package:flutter/material.dart';

class ListProductStoreScreen extends StatefulWidget {
  const ListProductStoreScreen({super.key});

  @override
  State<ListProductStoreScreen> createState() => _ListProductStoreScreenState();
}

class _ListProductStoreScreenState extends State<ListProductStoreScreen> {

  ProductStoreFirebase? productStoreFirebase;
  CategoriesFirebase? categoriesFirebase;
  
  @override
  void initState() {
    super.initState();
    productStoreFirebase = ProductStoreFirebase(); 
    categoriesFirebase = CategoriesFirebase();
  }

  Future<void> _eliminarProducto(String id) async {
    final confirm = await showOkCancelAlertDialog(
      context: context,
      title: 'Eliminar Producto',
      message: '¿Estás seguro de eliminar este producto?',
      okLabel: 'Sí, eliminar',
      cancelLabel: 'Cancelar',
    );

    if (confirm == OkCancelResult.ok) {
      await productStoreFirebase?.deleteProduct(id);
    }
  }

  Future<void> _agregarProducto() async {
    final categorias = await categoriesFirebase?.getCategoriesList();

    if (categorias!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay categorías disponibles.')),
      );
      return;
    }

    int? selectedCategoriaId;

    await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController conIdProducto = TextEditingController();
        final TextEditingController conNombreProducto = TextEditingController();
        final TextEditingController conDescripcion = TextEditingController();

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Nuevo Producto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: conIdProducto,
                  decoration: const InputDecoration(
                    labelText: 'ID del producto',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: conNombreProducto,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del producto',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: conDescripcion,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Seleccionar Categoría',
                  ),
                  items: categorias.map((cat) {
                    return DropdownMenuItem<int>(
                      value: cat['idCategoria'],
                      child: Text(cat['nombre']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCategoriaId = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final idProducto = int.tryParse(conIdProducto.text);
                final nombreProducto = conNombreProducto.text.trim();
                final descripcion = conDescripcion.text.trim();

                if (idProducto != null && nombreProducto.isNotEmpty && selectedCategoriaId != null) {
                  await productStoreFirebase?.addProduct({
                    'idProducto': idProducto,
                    'nombre': nombreProducto,
                    'descripcion': descripcion,
                    'idCategoria': selectedCategoriaId,
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Completa todos los campos')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

   Future<void> _editarProducto(String id, Map<String, dynamic> dataActual) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Editar Producto',
      message: 'Modifica los datos del producto',
      textFields: [
        DialogTextField(
          initialText: dataActual['nombre'],
          hintText: 'Nombre del producto',
        ),
        DialogTextField(
          initialText: dataActual['descripcion'],
          hintText: 'Descripción',
        ),
      ],
    );

    if (result != null && result.length == 2) {
      final nombreProducto = result[0];
      final descripcion = result[1];

      if (nombreProducto.isNotEmpty) {
        await productStoreFirebase?.updateProduct(id, {
          'nombre': nombreProducto,
          'descripcion': descripcion,
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Productos'),),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarProducto,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: productStoreFirebase?.selectProducts(), 
        builder: (context, snapshot){
           if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay productos registrados.'));
          }

          final productos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder:(context,index){
            final producto = productos[index];
              return ListTile(
                title: Text(producto['nombre']),
                subtitle: Text('Descripción: ${producto['descripcion']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editarProducto(producto.id, producto.data() as Map<String, dynamic>),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _eliminarProducto(producto.id),
                    ),
                  ],
                ),
              );
            }
            
          );

        }
      ),
    );
  }
}