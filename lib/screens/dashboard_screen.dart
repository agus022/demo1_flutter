import 'package:dark_light_button/dark_light_button.dart';
import 'package:demo1/utils/global_values.dart';
import 'package:demo1/utils/theme_settings.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("HOLA SECCION DOS"),
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
              onTap: (){},
              leading: Icon(Icons.design_services),
              title: Text('Practica Figma'),
              subtitle: Text('Frontend App'),
              trailing: Icon(Icons.chevron_right),
            )
          ],
        ),
      )
    );

  }
}