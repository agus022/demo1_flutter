import 'package:demo1/firebase_options.dart';
import 'package:demo1/screens/calendar_services.dart';
import 'package:demo1/screens/dashboard_screen.dart';
import 'package:demo1/screens/detail_popular_screen.dart';
import 'package:demo1/screens/details_product_screen.dart';
import 'package:demo1/screens/list_product_screen.dart';
import 'package:demo1/screens/list_services_screen.dart';
import 'package:demo1/screens/list_students_screen.dart';
import 'package:demo1/screens/login_screen.dart';
import 'package:demo1/screens/popular_screen.dart';
import 'package:demo1/screens/setting_screen.dart';
import 'package:demo1/screens/signup_screen.dart';
import 'package:demo1/screens/splash_screen.dart';
import 'package:demo1/screens/todo_firebase_screen.dart';
import 'package:demo1/screens/todo_screen.dart';
import 'package:demo1/utils/global_values.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await GlobalValues.loadTheme(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.themeApp,
      builder: (context,value,child) {
        return MaterialApp(
          theme: value,
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: SplashScreen(),
          routes: {
            "/list": (context) => const ListStudentScreen(),
            "/dash": (context) => const DashboardScreen(),
            "/listProduct":(context)=> const ListProductScreen(),
            "/product":(context)=> const DetailsProductScreen(),
            "/todoF":(context)=> const TodoFireBaseScreen(),
            "/signup":(context)=> const SignupScreen(),
            "/login":(context)=>const LoginScreen(),
            "/setting":(context)=>const SettingScreen(),
            "/api": (context) =>const PopularScreen(),
            "/movieDetail": (context) => DetailPopularScreen(),
            "/listService": (context) => const ListServicesScreen(),
            "/calendarService": (context) => const CalendarServices() 
          },
          //theme: ThemeData.dark(),
        );
      }
    );
  }
}