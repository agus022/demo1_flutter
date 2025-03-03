import 'package:demo1/database/task.database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  TaskDatabase? database;
  TextEditingController conTitle = TextEditingController();
  TextEditingController conDesc = TextEditingController();
  TextEditingController conDate = TextEditingController();
  TextEditingController conStatus = TextEditingController();


  @override
    void initState(){
    super.initState();
    database = TaskDatabase();
  }
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
          content: Container(
            height: 150,
            width: 200,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: conTitle,
                  decoration: InputDecoration(hintText: 'Titulo de la tarea '),
                ),
                TextFormField(
                  controller: conDesc,
                  maxLines: 3,
                  decoration: InputDecoration(hintText: 'Descripcion de la tarea '),
                ),
                TextFormField(
                  controller: conDate,
                  decoration: InputDecoration(hintText: 'Fecha de la tarea'),
                  onTap: () async{
                    DateTime? dateTodo = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), 
                      firstDate: DateTime(2000), 
                      lastDate: DateTime(2036)
                    );
                    if (dateTodo != null) {
                      String formattedDate = DateFormat('yyy-MM-dd').format(dateTodo);
                      setState(() {
                        conDate.text = formattedDate;
                      });
                    }
                  },
                  
                ),
                TextFormField(
                  controller: conStatus,
                  decoration: InputDecoration(hintText: 'Estatus de la tarea '),
                ),
            
              ],
            ),
          ),
        );
      }
    );
  }
}