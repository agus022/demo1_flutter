import 'package:cloud_firestore/cloud_firestore.dart';

class TodoFirebase {
  final firebase = FirebaseFirestore.instance;
  CollectionReference? collection;

  TodoFirebase(){
    collection = firebase.collection('task');
  }

  Stream<QuerySnapshot> selectTask(){
    return collection!.snapshots();
  }

  Future<void> addTask(Map<String, dynamic> task) async{
    await collection!.doc().set(task);
  }

  Future<void> updateTask(Map<String, dynamic> task, String id) async{
    await collection!.doc(id).set(task);
  }
  
  Future<void> deleteTask( String id) async{
    await collection!.doc(id).delete();
  }
}