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
        duration: const Duration(milliseconds: 4000),
        nextScreen:LoginScreen(),//proxima pantalla a mostrar despues de la animacion de "carga de la app"
        backgroundColor: Colors.white,
        splashScreenBody: Center(
            child: Center(child: Lottie.asset("assets/tecnm2.json", height: 300))
          ),
      ),
    );

  }
}