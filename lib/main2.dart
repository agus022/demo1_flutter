import 'package:flutter/material.dart';

void main() => runApp( MyApp());

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int contador =0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap:  (){        
          contador ++;
            print(contador);
            setState(() {});
        }, 
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purpleAccent,
            title: Center(
              child: Text('MY NEW APP FLUTTER :)', 
              style: TextStyle(
                fontFamily: 'Hollow',//tipo de letra que se descarga en archvo .otf o .ttf , EL NOMBRE SE ESPECIFICA EN EL ARCHIVO .yaml
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold
                
              )),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Image.network('https://celaya.tecnm.mx/wp-content/uploads/2021/02/cropped-FAV.png'),
            //Icon(Icons.add_box_rounded,color: Colors.purple),
            onPressed: (){
           
          }),
          body: Center (
            child: Text('Valor del contador: $contador',
          style: TextStyle(fontSize: 20)))
          ),
      ),
    );
  }
}
