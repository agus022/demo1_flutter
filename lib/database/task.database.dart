import 'dart:io';

import 'package:demo1/Models/todo_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskDatabase{
  static const NAMEDB ='TODODB';
  static const VERSIONDB = 1;

  static Database? _database;//   _ indica que es una variable privada

  Future<Database?> get database async {
    if(_database != null) return _database!;
    return _database = await initDatabase();

  }
  
  Future<Database?> initDatabase() async{
    //se crea la conexion a la base de datos 
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,NAMEDB);
    return openDatabase(
      path,
      version: VERSIONDB,
      onCreate: (db,version){
        String query = '''create table todo(
          idTodo integer primary key,
          titleTodo varchar(35),
          dscTodo varchar(100),
          dateTodo varchar(10),
          statusTodo boolean
          )''';
        db.execute(query);
      }
      );
  }

  Future<int> INSERTAR(String table,Map<String,dynamic> map) async{
    final con = await database;
    return con!.insert(table, map);
    
  }
  Future<int> DELETE(String table, int idTodo) async{
    final con = await database;
    return con!.delete(table,where: 'idTodo=?',whereArgs: [idTodo]);
  }
  Future<int> UPDATE(String table,Map<String, dynamic> map) async{
    final con= await database;
    return con!.update(table, map,where:'idTodo= ?',whereArgs: [map['idTodo']]);
  }
  Future<List<TodoModel>> SELECT()async{
    final con = await database;
    var result = await con!.query('todo');
    return result.map((task) => TodoModel.fromMap(task)).toList();


  }

}