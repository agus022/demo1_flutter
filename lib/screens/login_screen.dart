import 'package:demo1/screens/list_students_screen.dart';
import 'package:demo1/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isValidating = false ;


  @override
  Widget build(BuildContext context) {

    final txtUser = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Username: '
      ),
    );

    final txtPassword = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Password: '
      ),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/fondo.jpg"))
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 350,
              child: ValueListenableBuilder(
                valueListenable: GlobalValues.isValidating, 
                builder: (context,value,child){
                  return value ? CircularProgressIndicator() : Container();
                },
                ) //isValidating ? CircularProgressIndicator() : Container(),
            ),
            Positioned(
              top: 150,
              child: Lottie.asset("assets/tecnm2.json",height: 200 )
            ),
            Positioned(
              bottom: 50,
              child:Container(
                padding: EdgeInsets.all(10),
                height: 250,
                width: MediaQuery.of(context).size.width*.9,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10)
                ),
                child :Column(
                children: [
                  txtUser,
                  SizedBox(height: 10,),
                  txtPassword,
                  GestureDetector(
                    // onTap: () => Navigator.push(
                    //   context, MaterialPageRoute(builder: (context)=>ListStudentScreen())),
                    onTap: (){
                      //isValidating = true;
                      GlobalValues.isValidating.value=true;
                      Future.delayed(Duration(milliseconds: 4000)).then((onValue){
                      GlobalValues.isValidating.value=false;
                      Navigator.pushNamed(context, "/list");
                      },);
                      },
                    child: Image.asset("assets/boton.png",
                    height: 80,
                    ),
                  )

                ],
              )
              )
              )
          ],
        ),
      ),
    );
  }
}