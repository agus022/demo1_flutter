import 'package:dark_light_button/dark_light_button.dart';
import 'package:demo1/utils/global_values.dart';
import 'package:demo1/utils/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});


  Future<void> logout(BuildContext context)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedUser');
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard - Agus"),
        actions: [
            DarlightButton(
              type: Darlights.DarlightFour,
              options: DarlightFourOption(),
              onChange: (value){
                if (value== ThemeMode.light){
                  GlobalValues.themeApp.value = ThemeSettings.lightTheme();
                }else{
                  GlobalValues.themeApp.value = ThemeData.dark();
                }
            })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar( backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/61722297?v=4')),
              accountName: Text('Agustin Flores Silva'),
              accountEmail: Text('flores.jorge.1j@gmail.com')
            ),
            ListTile(
              onTap: ()=> Navigator.pushNamed(context, "/listProduct"),
              leading: Icon(Icons.design_services),
              title: Text('Practica Figma'),
              subtitle: Text('Frontend App'),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: ()=> Navigator.pushNamed(context, "/todo"),
              leading: Icon(Icons.design_services),
              title: Text('Todo App'),
              subtitle: Text('Task List'),
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