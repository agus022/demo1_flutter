import 'package:demo1/screens/dashboard_screen.dart';
import 'package:demo1/screens/list_product_screen.dart';
import 'package:demo1/screens/list_students_screen.dart';
import 'package:demo1/screens/splash_food_screen.dart';
import 'package:demo1/screens/splash_screen.dart';
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
          theme: value,
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: SplashFoodScreen(),
          routes: {
            "/list": (context) => const ListProductScreen(),
            "/dash": (context) => const DashboardScreen(),
          },
          //theme: ThemeData.dark(),
        );
      }
    );
  }
}