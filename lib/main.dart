import 'package:demo1/views/item_student_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ALUMNOS'),
        ),
        body: ListView(
        
          children: [
            const ListTile(
              title: Text('Alumnos Grupo Base',style: TextStyle(fontSize: 20),),
              subtitle: Text('Enero - Junio'),
              trailing: Column(
                children: [
                  Text('2024', style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                ItemStudentView(),
                SizedBox(height: 10,),
                ItemStudentView(),
                SizedBox(height: 10,),
                ItemStudentView(),
                SizedBox(height: 10,),
                ItemStudentView(),
                SizedBox(height: 10,),
                ItemStudentView()
              ],
            )
          ],
        )
      ),
    );
  }
}