import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:demo1/database/task.database.dart';
import 'package:demo1/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  late TaskDatabase? database; 
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
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.updList,
        builder: (context,value,widget) {
          return FutureBuilder(
            future: database!.SELECT(), 
            builder: (context,snapshot){
              if(snapshot.hasError){
                //return Text(snapshot.error.toString());
                return const Center(child: Text('Algo ocurrio durante la ejecucion. ERROR!!!'),);
              }else{
                if(snapshot.hasData){
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,index){
                      var obj = snapshot.data![index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 150,
                        child: Column(  
                          children: [
                            
                            ListTile(
                              title: Text(obj.titleTodo!),
                              subtitle: Text(obj.dateTodo!),
                              trailing: Builder(builder: (context){
                                if(obj.statusTodo! == true){
                                  return Icon(Icons.check);
                                }else{
                                  return Icon(Icons.close);
                                }
                              }),
                            ),
                            Text(obj.dscTodo!),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    conTitle.text = obj.titleTodo!;
                                    conDesc.text =obj.dscTodo!;
                                    conDate.text = obj.dateTodo!;
                                    conStatus.text = obj.statusTodo!.toString();

                                    _dialogBuilder(context,obj.idTodo!);
                                  }, 
                                  icon: Icon(Icons.edit)
                                ),
                                IconButton(
                                  onPressed: (){
                                    database!.DELETE('todo', obj.idTodo!).then((value){
                                      if(value > 0){
                                        GlobalValues.updList.value =!GlobalValues.updList.value;
                                      }
                                    });
                                  }, 
                                  icon: Icon((Icons.delete))
                                )
                              ],
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
            );
        }
      ),
    );

  }
  Future<void> _dialogBuilder(BuildContext context,[int idTodo = 0]){//los corchetes define que son valores opcionales , no afectan si no estan pero si estan se toman en cuenta 
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
                    if (idTodo == 0){
                    database!.INSERTAR(
                      "todo", 
                      {
                        'titleTodo' :conTitle.text,
                        'dscTodo' :conDesc.text,
                        'dateTodo' :conDate.text,
                        'statusTodo' :false
                      }
                    ).then((value) {
                      if(value > 0){
                        GlobalValues.updList.value = !GlobalValues.updList.value;
                        ArtSweetAlert.show(
                          context: context, 
                          artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.success,
                            title: 'ACTUALIZAR :)',
                            text: 'La terea se actualizo correctamente'
                          )
                        );
                      }
                    },);
                    }else{
                      database!.UPDATE(
                      "todo", 
                      {
                        'idTodo': idTodo,
                        'titleTodo' :conTitle.text,
                        'dscTodo' :conDesc.text,
                        'dateTodo' :conDate.text,
                        'statusTodo' :false
                      }
                    ).then((value) {
                      if(value > 0){
                        GlobalValues.updList.value = !GlobalValues.updList.value;
                        ArtSweetAlert.show(
                          context: context, 
                          artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.success,
                            title: 'AGREGAR :)',
                            text: 'La terea se registro correctamente'
                          )
                        );
                      }
                    },);
                    }
                    conTitle.text='';
                    conDate.text='';
                    conDesc.text='';
                    conStatus.text='';
                    Navigator.pop(context);
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