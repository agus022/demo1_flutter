import 'dart:io';

import 'package:demo1/Models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabase{
  static const NAMEDB ='GENERAL.db';
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
        String query = '''create table user(
          idUser integer primary key,
          fullName varchar(35) not null,
          email varchar(100) unique not null,
          password text not null,
          picture text
          )''';
        db.execute(query);
      }
      );
  }

  Future<int> InsertUser(String table,Map<String,dynamic> map) async{
    final con = await database;
    return con!.insert(table, map);
    
  }
  Future<int> DeleteUser(String table, int idTodo) async{
    final con = await database;
    return con!.delete(table,where: 'idUser=?',whereArgs: [idTodo]);
  }
  Future<int> UpdateUser(String table,Map<String, dynamic> map) async{
    final con= await database;
    return con!.update(table, map,where:'idUser= ?',whereArgs: [map['idUser']]);
  }
  Future<List<UserModel>>SelectUser()async{
    final con = await database;
    var result = await con!.query('user');
    return result.map((task) => UserModel.fromMap(task)).toList();
  }

  Future<Map<String, dynamic>?> getUserAuth(String email, String password) async {
  final con = await database;
  List<Map<String, dynamic>> result = await con!.query(
    'user',
    where: 'email = ? AND password = ?',
    whereArgs: [email, password],
  );
  return result.isNotEmpty ? result.first : null;
}


}