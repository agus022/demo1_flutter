import 'package:demo1/firebase/todo_firebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoFireBaseScreen extends StatefulWidget {
  const TodoFireBaseScreen({super.key});

  @override
  State<TodoFireBaseScreen> createState() => _TodoFireBaseScreenState();
}

class _TodoFireBaseScreenState extends State<TodoFireBaseScreen> {
  TodoFirebase? todoFirebase;
  TextEditingController conTitle = TextEditingController();
  TextEditingController conDesc = TextEditingController();
  TextEditingController conDate = TextEditingController();
  TextEditingController conStatus = TextEditingController();


  @override
  void initState() {
    super.initState();
    todoFirebase = TodoFirebase();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tareas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _dialogBuilder(context),
        child:Icon(Icons.add_task) ,
      ),
      body: StreamBuilder(
        stream: todoFirebase!.selectTask(), 
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var obj = snapshot.data!.docs[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  height: 150,
                  child: Column(  
                    children: [
                      
                      ListTile(
                        title: Text(obj.get('titleTodo')),
                        subtitle: Text(obj.get('dscTodo')),
                        trailing: Builder(builder: (context){
                          if(obj.get('statusTodo') == true){
                            return Icon(Icons.check);
                          }else{
                            return Icon(Icons.close);
                          }
                        }),
                      ),
                      Text(obj.get('dscTodo')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: (){
                              conTitle.text = obj.get('titleTodo');
                              conDesc.text =obj.get('dscTodo');
                              conDate.text = obj.get('dateTodo');
                              conStatus.text = obj.get('statusTodo');

                              _dialogBuilder(context,obj.id);
                            }, 
                            icon: Icon(Icons.edit)
                          ),
                          IconButton(
                            onPressed: (){
                              todoFirebase!.deleteTask(obj.id);
                            }, 
                            icon: Icon((Icons.delete))
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }else if(!snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(child: CircularProgressIndicator());
        }
        ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context,[String idTodo = "0"]){//los corchetes define que son valores opcionales , no afectan si no estan pero si estan se toman en cuenta 
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: idTodo == 0 ? Text('Add Task'):Text('Edit Task'),
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
                Divider(),
                ElevatedButton(
                  onPressed: (){
                    todoFirebase!.addTask({ 
                      'titleTodo': conTitle.text, 
                      'dscTodo': conDesc.text, 
                      'dateTodo': conDate.text, 
                      'statusTodo': conStatus.text,
                    });
                  }, 
                  child: Text('Guardar'))
              ],
            ),
          ),
        );
      }
    );
  }
}