import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:demo1/database/user.database.dart';
import 'package:demo1/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  late UserDatabase? database; 
  TextEditingController conFullName = TextEditingController();
  TextEditingController conEmail = TextEditingController();
  TextEditingController conPassword = TextEditingController();
  TextEditingController conPicture = TextEditingController();
  File? image;

  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }


  Future<void> pickImage() async{
    final picker = ImagePicker();
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickerFile != null){
      setState(() {
        image = File(pickerFile.path);
      });
    }
  }

  Future<void> takePicture() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: ImageSource.camera, 
    preferredCameraDevice: CameraDevice.rear,
  );

  if (pickedFile != null) {
    setState(() {
      image = File(pickedFile.path);
    });
  }
}

@override
  void initState(){
    super.initState();
    database = UserDatabase();
  }
 Widget build(BuildContext context) {

    final txtNewNameUser = TextFormField(
      controller: conFullName,
      decoration: InputDecoration(
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
        hintText:'Jorge Agustin Flores Silva',
        hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
        filled: true,
        fillColor: Color(0xFFF0F5FA),
        //contentPadding: EdgeInsets.symmetric(vertical: 25,horizontal: 10)
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return 'El nombre es obligatorio';
        return null;
      },
    );

    final txtNewEmailUser = TextFormField(
      controller: conEmail,
      decoration: InputDecoration(
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
        hintText:'example@gmail.com',
        hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
        filled: true,
        fillColor: Color(0xFFF0F5FA),
        //contentPadding: EdgeInsets.symmetric(vertical: 25,horizontal: 10)
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return 'El email es obligatorio';
        if (!isValidEmail(value)) return 'Ingrese un email válido';
        return null;
      },
    );

    final txtNewPasswordUser = TextFormField(
      controller: conPassword,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none), 
        hintText: '* * * * * * * *',
        hintStyle: TextStyle(color: Color(0xFFA0A5BA)),
        filled: true,
        fillColor:  Color(0xFFF0F5FA),
        //contentPadding: EdgeInsets.symmetric(vertical: 25,horizontal: 10)
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return 'La contraseña es obligatorio';
        if (value.length < 3) return 'Debe tener al menos 6 caracteres';
        return null;
      },
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
              "Sing Up",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Positioned(
              top: 165,
              child: Text("Please sign up to get started.",style: TextStyle(fontSize: 15, color: Colors.white),)
          ),
          Positioned(
              top: 250,
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
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FULL NAME: ',style: TextStyle(fontSize: 13, color: Color(0xFF32343E))),
                          txtNewNameUser,//NOMBRE COMPLETO DEL USUARIO 
                          SizedBox(height:15),
                          Text('EMAIL:',style: TextStyle(fontSize: 13, color: Color(0xFF32343E))),
                          txtNewEmailUser,//CORREO ELECTRONICO DEL USUARIO 
                          SizedBox(height:15),
                          Text('PASSWORD:',style: TextStyle(fontSize: 13,color: Color(0xFF32343E))),
                          txtNewPasswordUser,//CONTRASENA DEL USUARIO
                          SizedBox(height: 15,),
                          Text('PHOTO:',style: TextStyle(fontSize: 13,color: Color(0xFF32343E))),
                          //FOTOGRAFIA 
                          Row(
                            children: [
                              Text('Foto galeria o nueva foto:',style: TextStyle(color: Color(0xFF32343E))),
                              SizedBox(width: 5,),
                              IconButton(
                                //label: Text('Seleccionar',style: TextStyle(fontSize: 10),),
                                icon: Icon(Icons.photo_camera_back,size: 30,),
                                style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: Size(10,10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                                
                                padding: EdgeInsets.zero 
                              ), 
                                onPressed: pickImage,
                              ),
                              IconButton(
                                //label: Text('Seleccionar',style: TextStyle(fontSize: 10),),
                                icon: Icon(Icons.camera_alt_outlined,size: 30,),
                                style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: Size(10,10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),), 
                                padding: EdgeInsets.zero 
                                
                              ), 
                                onPressed: takePicture,
                              ),
                            ],
                          ),
                          Center(
                            child: Column(
                              children: [
                                CircleAvatar(
                                    radius: 65,
                                    backgroundColor: Colors.grey.shade300,
                                    backgroundImage: image!=null ? FileImage(image!):null, 
                                ),
                                image == null?Text('No se ha seleccionado imagen',style: TextStyle(color: Color(0xFFA0A5BA),fontSize: 12),):Text('Imagen seleccionada',style: TextStyle(color: Color(0xFFA0A5BA),fontSize: 12)),
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                          Divider(),
                            ElevatedButton(
                              onPressed: (){
                                if (!_formKey.currentState!.validate()) return;
                                database!.InsertUser(
                                 "user", 
                                  {
                                    'fullName':conFullName.text,
                                    'email':conEmail.text,
                                    'password':conPassword.text,
                                    'picture':image?.path
                                  }
                                ).then((value){
                                  if(value > 0){
                                    ArtSweetAlert.show(
                                      context: context, 
                                      artDialogArgs: ArtDialogArgs(
                                        type: ArtSweetAlertType.success,
                                        title: 'CORRECTO :)',
                                        text: 'El usuario se registro correctamente'
                                    )
                                    );
                                  }else {
                                    ArtSweetAlert.show(
                                      context: context, 
                                      artDialogArgs: ArtDialogArgs(
                                        type: ArtSweetAlertType.success,
                                        title: 'ERROR :(',
                                        text: 'Error al registrar usuario'
                                    )
                                    );
                                  }
                                });
                                GlobalValues.isValidating.value=true;
                                Future.delayed(Duration(milliseconds: 4000)).then((onValue){
                                GlobalValues.isValidating.value=false;
                                Navigator.pushNamed(context, "/login");
                                },);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                                backgroundColor: Color(0xFFFF7622),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ), 
                              child: Text('Sign Up', style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold, fontSize: 15),)
                            ), 
                                        
                        ],
                      ),
                    ),
                  )
                )
                    
                  )
                  
        ],
      ),
    );
  }
}