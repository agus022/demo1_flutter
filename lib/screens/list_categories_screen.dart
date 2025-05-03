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
    message: 'Ingresa nombre de la categoria nueva',
    textFields: const [
      DialogTextField(
        hintText: 'Nombre de la categoría',
      ),
    ],
  );

if (result != null && result.isNotEmpty) {
    final nombreCategoria = result.first;

    if (nombreCategoria.isNotEmpty) {
      await categoriesFirebase?.addCategory({
        'nombre': nombreCategoria,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Categoría agregada correctamente')),
      );
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
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, size: 30,color: Colors.white,),
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
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          categoria['nombre'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _editarCategoria(categoria.id, categoria['nombre']),
                        icon: const Icon(Icons.edit_rounded),
                        color: Colors.indigo,
                      ),
                      IconButton(
                        onPressed: () => _eliminarCategoria(categoria.id),
                        icon: const Icon(Icons.delete_rounded),
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                ),
              );

            },
          );
        }
      ),
    );
  }
}