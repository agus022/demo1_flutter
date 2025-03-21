import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:demo1/database/user.database.dart';
import 'package:demo1/firebase/auth_firebase.dart';
import 'package:demo1/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  AuthFirebase? auth;
  bool isValidating = false ;
  late UserDatabase? database; 
  TextEditingController conEmail = TextEditingController();
  TextEditingController conPassword = TextEditingController();




    @override
    void initState(){
      super.initState();
      database = UserDatabase();
      auth = AuthFirebase();
      checkSession();
    }

    //guarda la sesion con SharedPreferences lo cual mentiene la sesion activa y si hay previamente una sesion inciada te redirije al dash
    Future<void> saveSession(String email) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('loggedUser', email);
    }

    //revisa si hay una sesion gurdada y si hay redirige al dash
    Future<void> checkSession() async{
      final prefs = await SharedPreferences.getInstance();
      String? savedEmail = prefs.getString('loggedUser');
      if(savedEmail != null){
        Navigator.pushReplacementNamed(context, "/dash");
      }
    }

    Future<void> loginUser() async {
    setState(() {
      isValidating = true;
    });

    String email = conEmail.text.trim();
    String password = conPassword.text.trim();

    var user = await database?.getUserAuth(email, password);

    setState(() {
      isValidating = false;
    });

    if (user != null) {
      await saveSession(email);
      Navigator.pushNamed(context, "/dash");
    } else {
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Error",
          text: "Usuario o contraseña incorrectos",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final txtUser = TextFormField(
      controller: conEmail,
      decoration: InputDecoration(
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
        hintText:'example@gmail.com',
        hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
        filled: true,
        fillColor: Color(0xFFF0F5FA),

      ),
    );

    final txtPassword = TextFormField(
      controller: conPassword,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
        hintText: '* * * * * * * *',
        hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
        filled: true,
        fillColor:  Color(0xFFF0F5FA),
        //contentPadding: EdgeInsets.symmetric(vertical: 25,horizontal: 10)
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
              bottom: 0,
              child:Container(
                padding: EdgeInsets.all(15),
                height: 350,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10)
                ),
                child :Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('EMAIL:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xFFA0A5BA))),
                  txtUser,
                  SizedBox(height: 15,),
                  Text('PASSWORD:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xFFA0A5BA))),
                  txtPassword,
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        label: Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                        icon: Icon(Icons.add_reaction_outlined, color: Colors.white,size: 23,),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF18396a),
                          minimumSize: Size(MediaQuery.of(context).size.width*0.4,50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          )
                        ),
                        onPressed: (){
                          GlobalValues.isValidating.value=true;
                          Future.delayed(Duration(milliseconds: 3000)).then((onValue){
                          GlobalValues.isValidating.value=false;
                          Navigator.pushNamed(context, "/signup");
                          });
                        },  
                      ),
                      ElevatedButton.icon(
                        label: Text('Log In',style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                        icon: Icon(Icons.login_rounded, color: Colors.white,size: 23,),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF18396a),
                          minimumSize: Size(MediaQuery.of(context).size.width*0.4,50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          )
                        ),
                        onPressed: (){
                          GlobalValues.isValidating.value=true;
                          Future.delayed(Duration(milliseconds: 3000)).then((onValue){
                          GlobalValues.isValidating.value=false;
                          loginUser();
                          });
                        },  
                      ),
                      // GestureDetector(
                      //   // onTap: () => Navigator.push(
                      //   //   context, MaterialPageRoute(builder: (context)=>ListStudentScreen())),
                      //   onTap: loginUser,
                      //     //(){
                      //     //isValidating = true;
                      //     // GlobalValues.isValidating.value=true;
                      //     // Future.delayed(Duration(milliseconds: 4000)).then((onValue){
                      //     // GlobalValues.isValidating.value=false;
                      //     // Navigator.pushNamed(context, "/dash");
                      //     // },);
                      //     //},
                      //   child: Image.asset("assets/boton.png",
                      //   height: 80,
                      //   ),
                      // ),
                      // GestureDetector(
                      //   // onTap: () => Navigator.push(
                      //   //   context, MaterialPageRoute(builder: (context)=>ListStudentScreen())),
                      //   onTap: (){
                      //     //isValidating = true;
                      //     GlobalValues.isValidating.value=true;
                      //     Future.delayed(Duration(milliseconds: 4000)).then((onValue){
                      //     GlobalValues.isValidating.value=false;
                      //     Navigator.pushNamed(context, "/signup");
                      //     },);
                      //     },
                      //   child: Image.asset("assets/signup.png",
                      //   height: 100,
                      //   ),
                      // ),
                      
                    ],
                  ),
                  

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