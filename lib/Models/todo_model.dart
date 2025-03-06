class TodoModel {
  int? idTodo;
  String? titleTodo;
  String? dscTodo;
  String? dateTodo;
  bool? statusTodo;

//constructor sin cuerpo 
  TodoModel({this.idTodo,this.titleTodo,this.dscTodo,this.dateTodo,this.statusTodo});
  
  factory TodoModel.fromMap(Map<String,dynamic> map){
    return TodoModel(
      idTodo:map['idTodo'],
      titleTodo:map['titleTodo'],
      dscTodo: map['dscTodo'],
      dateTodo: map['dateTodo'],
      statusTodo: true
    );
  }

}