import 'package:flutter/material.dart';
import 'package:notes/Colors.dart';
import 'dart:async';
import 'package:notes/Screen/login%20and%20signup/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double mWidth = 100;
  double mHeight = 100;
  double textOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Animate the logo size
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        mWidth = 300;
        mHeight = 300;
      });
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        textOpacity = 1.0;
      });
    });


    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.spColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Animation
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: mWidth,
              height: mHeight,
              child: Image.asset(
                "assets/images/notes 1.png",
              ),
            ),
            const SizedBox(height: 20),
            // Text Animation (fade in)
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: textOpacity,
              child: const Text(
                "Digital Notes",
                style: TextStyle(fontSize: 50, fontFamily: "myFontCu", color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
