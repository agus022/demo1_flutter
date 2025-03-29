import 'dart:io';

import 'package:dark_light_button/dark_light_button.dart';
import 'package:demo1/Models/user_model.dart';
import 'package:demo1/database/user.database.dart';
import 'package:demo1/utils/global_values.dart';
import 'package:demo1/utils/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserModel? loggedUser;
  late UserDatabase database;

    @override
  void initState() {
    super.initState();
    database = UserDatabase();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('loggedUser'); // Obtener el email del usuario logueado

    if (userEmail != null) {
      List<UserModel> users = await database.SelectUser();
      UserModel? user = users.firstWhere(
        (u) => u.email == userEmail,
        orElse: () => UserModel(idUser: 0, fullName: 'Usuario Desconocido', email: '', password: '', picture: null),
      );

      setState(() {
        loggedUser = user;
      });
    }
  }
  
  Future<void> logout(BuildContext context)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedUser');
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: 
              CircleAvatar(
                backgroundImage: loggedUser?.picture != null
                    ? FileImage(File(loggedUser!.picture!)) // Si tiene imagen guardada, la muestra
                    : AssetImage('assets/default_avatar.png') as ImageProvider, // Imagen por defecto
              ),
              accountName: Text(loggedUser?.fullName ?? "Cargando..."),
              accountEmail: Text(loggedUser?.email ?? "Cargando..."),
            ),
            ListTile(
              onTap: ()=> Navigator.pushNamed(context, "/listProduct"),
              leading: Icon(Icons.fastfood),
              title: Text('Figma Challenge'),
              subtitle: Text('Frontend App'),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: ()=> Navigator.pushNamed(context, "/todoF"),
              leading: Icon(Icons.design_services_rounded),
              title: Text('Todo App'),
              subtitle: Text('Task List'),
              trailing: Icon(Icons.chevron_right),
            ),
              ListTile(
              onTap: ()=> Navigator.pushNamed(context, "/api"),
              leading: Icon(Icons.movie),
              title: Text('Movie Popular API'),
              subtitle: Text('Top list popular movie',style: TextStyle(fontSize: 13),),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: ()=> Navigator.pushNamed(context, "/setting"),
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              subtitle: Text('Customize your application',style: TextStyle(fontSize: 13),),
              trailing: Icon(Icons.chevron_right),
            ),
            Divider(),
            ListTile(
              onTap: () => logout(context),
              leading: Icon(Icons.logout_rounded,color: Colors.red,),
              title: Text('Cerrar Sesion',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
            )
          ],
        ),
      )
    );

  }
}