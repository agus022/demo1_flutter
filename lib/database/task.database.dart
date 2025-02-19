import 'dart:io';

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
        String query = 'create table ';
        db.execute(query);
      }
      );
  }
}