class TodoModel {
  int? idTodo;
  String? titleTodo;
  String? dscTodo;
  String? date;
  bool? statusTodo;

//constructor sin cuerpo 
  TodoModel({this.idTodo,this.titleTodo,this.dscTodo,this.date,this.statusTodo});
  
  factory TodoModel.fromMap(Map<String,dynamic> map){
    return TodoModel(
      idTodo:map['idTodo'],
      titleTodo:map['titleTodo'],
      dscTodo: map['dscTodo'],
      date: map['dateTodo'],
      statusTodo: map['statusTodo']
    );
  }

}