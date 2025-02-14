import 'package:demo1/screens/dashboard_screen.dart';
import 'package:demo1/screens/list_students_screen.dart';
import 'package:demo1/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: SplashScreen(),
      routes: {
        "/list": (context) => const ListStudentScreen(),
        "/dash": (context) => const DashboardScreen(),
      },
      theme: ThemeData.dark(),
    );
  }
}