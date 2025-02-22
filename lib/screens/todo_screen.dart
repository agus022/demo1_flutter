import 'package:demo1/database/task.database.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  TaskDatabase? database;
  void initState(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDo List'),),
      body: FutureBuilder(
        future: database!.SELECT(), 
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Center(child: Text('Algo ocurrio durante la ejecucion. ERROR!!!'),);
          }else{
            if(snapshot.hasData){
              return ListView.builder(
                itemBuilder: (context,index){

                }
                );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
        }
        ),
    );
  }
}