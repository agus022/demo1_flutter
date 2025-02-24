import 'package:demo1/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginFoodScreen extends StatefulWidget {
  const LoginFoodScreen({super.key});

  @override
  State<LoginFoodScreen> createState() => _LoginFoodScreenState();
}

class _LoginFoodScreenState extends State<LoginFoodScreen> {
  @override
  Widget build(BuildContext context) {
    final txtUser = TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
        hintText:'example@gmail.com',
        hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
        filled: true,
        fillColor: Color(0xFFF0F5FA),
        contentPadding: EdgeInsets.symmetric(vertical: 25,horizontal: 10)
      ),
    );

    final txtPassword = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none), 
        hintText: '* * * * * * * *',
        hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
        filled: true,
        fillColor:  Color(0xFFF0F5FA),
        contentPadding: EdgeInsets.symmetric(vertical: 25,horizontal: 10)
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFF121223),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/top_detail_login.png",
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/top_right_login.png",
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 118,
            child: Text(
              "Log In",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Positioned(
              top: 165,
              child: Text("Please sign in to your existing account.",style: TextStyle(fontSize: 15, color: Colors.white),)
          ),
          Positioned(
              top: 300,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.all(35),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EMAIL',style: TextStyle(fontSize: 15, color: Color(0xFF32343E))),
                      SizedBox(height: 10),
                      txtUser,
                      SizedBox(height: 30),
                      Text('PASSWORD',style: TextStyle(fontSize: 15,color: Color(0xFF32343E))),
                      SizedBox(height: 10),
                      txtPassword,
                      SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (value){}),
                              Text('Remember me')
                            ],
                          ),
                          Text('Forgot Password',style: TextStyle(color: Color(0xFFFF7622)),),
                          
                        ],
                      ),
                      SizedBox(height: 16,),
                        ElevatedButton(
                          onPressed: (){
                          GlobalValues.isValidating.value=true;
                          Future.delayed(Duration(milliseconds: 1000)).then((onValue){
                          GlobalValues.isValidating.value=false;
                          Navigator.pushNamed(context, "/listProduct");
                          },);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF7622),
                            minimumSize: Size(double.infinity,70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ), 
                          child: Text('LOG IN', style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold, fontSize: 15),)
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?", style: TextStyle(color: Color(0xFF646982)),),
                            SizedBox(width: 15,),
                            Text('SIGN UP' ,style:TextStyle(color:Color(0xFFFF7622), fontWeight: FontWeight.bold),)
                          ],
                        ),
                        SizedBox(height: 35,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Or', style: TextStyle(fontSize: 15,color: Color(0xFF646982)),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(icon: FaIcon(FontAwesomeIcons.facebook,color: Color(0xFF395998),size: 50,), onPressed: () {  },),
                            SizedBox(width: 15,),
                            IconButton(icon: FaIcon(FontAwesomeIcons.twitter,color: Color(0xFF169CE8),size: 50,), onPressed: () {  },),
                            SizedBox(width: 15,),
                            IconButton(icon: FaIcon(FontAwesomeIcons.apple,color: Color(0xFF1B1F2F),size: 50,), onPressed: () {  },)
                            
                          ],
                        )


                    ],
                  )
                )
                    
                  )
                  
        ],
      ),
    );
  }
}
