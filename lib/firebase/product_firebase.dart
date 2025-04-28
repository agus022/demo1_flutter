import 'package:cloud_firestore/cloud_firestore.dart';

class ProductStoreFirebase {
  final firebase = FirebaseFirestore.instance;
  CollectionReference? collection;

  ProductStoreFirebase(){
    collection = firebase.collection('products');
  }

  Stream<QuerySnapshot> selectProducts() {
    return firebase.collection('products').snapshots();
  }

  Future<void> addProduct(Map<String, dynamic> product) async {
    await firebase.collection('products').add(product);
  }

  Future<void> updateProduct(String id, Map<String, dynamic> data) async {
    await firebase.collection('products').doc(id).update(data);
  }

  Future<void> deleteProduct(String id) async {
    await firebase.collection('products').doc(id).delete();
  }
}