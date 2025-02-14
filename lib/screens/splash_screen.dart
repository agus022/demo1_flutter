import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:demo1/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen(
        duration: const Duration(milliseconds: 2000),
        nextScreen:LoginScreen(),
        backgroundColor: Colors.white,
        splashScreenBody: Center(
            child: Lottie.asset("assets/tecnm2.json", height: 200)
          ),
      ),
    );

  }
}