import 'package:demo1/screens/list_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashFoodScreen extends StatefulWidget {
  const SplashFoodScreen({super.key});

  @override
  State<SplashFoodScreen> createState() => _SplashFoodScreenState();
}



class _SplashFoodScreenState extends State<SplashFoodScreen> {
  @override
    void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ListProductScreen()),
      );
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("assets/top_detail.png", width: 150),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/bottom_detail.png", width: 200),
          ),
          Center(
            // child: Image.asset("assets/Logofood.png",width: 350,),
            // child: Lottie.asset("assets/food.json", height: 350),
            child: Lottie.asset("assets/foodies.json", height: 350),
          ),
        ],
      )
    );
  }
}