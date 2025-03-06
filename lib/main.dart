import 'package:demo1/screens/dashboard_screen.dart';
import 'package:demo1/screens/details_product_screen.dart';
import 'package:demo1/screens/list_product_screen.dart';
import 'package:demo1/screens/list_students_screen.dart';
import 'package:demo1/screens/login_screen.dart';
import 'package:demo1/screens/setting_screen.dart';
import 'package:demo1/screens/signup_screen.dart';
import 'package:demo1/screens/splash_food_screen.dart';
import 'package:demo1/screens/splash_screen.dart';
import 'package:demo1/screens/todo_screen.dart';
import 'package:demo1/utils/global_values.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.themeApp,
      builder: (context,value,child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Sen'
          ),
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: SplashScreen(),
          routes: {
            "/list": (context) => const ListStudentScreen(),
            "/dash": (context) => const DashboardScreen(),
            "/listProduct":(context)=> const ListProductScreen(),
            "/product":(context)=> const DetailsProductScreen(),
            "/todo":(context)=> const TodoScreen(),
            "/signup":(context)=> const SignupScreen(),
            "/login":(context)=>const LoginScreen(),
            "/setting":(context)=>const SettingScreen()
          },
          //theme: ThemeData.dark(),
        );
      }
    );
  }
}