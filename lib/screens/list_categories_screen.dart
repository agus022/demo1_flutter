import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo1/firebase/categories_firebase.dart';
import 'package:flutter/material.dart';

class ListCategoriesScreen extends StatefulWidget {
  const ListCategoriesScreen({super.key});

  @override
  State<ListCategoriesScreen> createState() => _ListCategoriesScreenState();
}

class _ListCategoriesScreenState extends State<ListCategoriesScreen> {

  CategoriesFirebase? categoriesFirebase;

  @override
  void initState() {
    super.initState();
    categoriesFirebase = CategoriesFirebase(); 
  }

Future<void> _agregarCategoria() async {
  final result = await showTextInputDialog(
    context: context,
    title: 'Nueva Categoría',
    message: 'Completa los datos',
    textFields: const [
      DialogTextField(
        hintText: 'ID de categoría (número)',
        keyboardType: TextInputType.number,
      ),
      DialogTextField(
        hintText: 'Nombre de la categoría',
      ),
    ],
  );

  if (result != null && result.length == 2) {
    final idCategoriaStr = result[0];
    final nombreCategoria = result[1];

    if (idCategoriaStr.isNotEmpty && nombreCategoria.isNotEmpty) {
      final idCategoria = int.tryParse(idCategoriaStr);

      if (idCategoria != null) {
        await categoriesFirebase?.addCategory({
          'idCategoria': idCategoria,
          'nombre': nombreCategoria,
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ID debe ser un número válido')),
        );
      }
    }
  }
}

  Future<void> _eliminarCategoria(String id) async {
    final confirm = await showOkCancelAlertDialog(
      context: context,
      title: 'Eliminar Categoría',
      message: '¿Estás seguro de eliminar esta categoría?',
      okLabel: 'Sí, eliminar',
      cancelLabel: 'Cancelar',
    );

    if (confirm == OkCancelResult.ok) {
      await categoriesFirebase?.deleteCategory(id);
    }
  }

  Future<void> _editarCategoria(String id, String nombreActual) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Editar Categoría',
      message: 'Modifica el nombre de la categoría',
      textFields: [
        DialogTextField(
          initialText: nombreActual,
          hintText: 'Nuevo nombre',
        ),
      ],
    );

    if (result != null && result.isNotEmpty) {
      await categoriesFirebase?.updateCategory(id, {
        'nombre': result.first,
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Categorias'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarCategoria,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: categoriesFirebase?.selectCategories(), 
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay categorías registradas.'));
          }

          final categorias = snapshot.data!.docs;

          return ListView.builder(
            itemCount: categorias.length,
            itemBuilder: (context, index) {
              final categoria = categorias[index];
              return ListTile(
                title: Text(categoria['nombre']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editarCategoria(categoria.id, categoria['nombre']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _eliminarCategoria(categoria.id),
                    ),
                  ],
                ),
              );
            },
          );
        }
      ),
    );
  }
}