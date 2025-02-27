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
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _dialogBuilder(context),
        child:Icon(Icons.add_task) ,
        ),
      body: FutureBuilder(
        future: database!.SELECT(), 
        builder: (context,snapshot){
          if(snapshot.hasError){
            //return Text(snapshot.error.toString());
            return const Center(child: Text('Algo ocurrio durante la ejecucion. ERROR!!!'),);
          }else{
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index){
                  var obj = snapshot.data![index];
                  return Container(
                    height: 150,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(obj.titleTodo!),
                          subtitle: Text(obj.date!),
                          trailing: Builder(builder: (context){
                            if(obj.statusTodo! == true){
                              return Icon(Icons.check);
                            }else{
                              return Icon(Icons.close);
                            }
                          }),
                        )
                      ],
                    ),
                  );
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
  Future<void> _dialogBuilder(BuildContext context){
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text('Add Task'),
        );
      }
    );
  }
}