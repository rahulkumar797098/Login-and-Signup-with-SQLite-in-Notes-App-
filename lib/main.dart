import 'package:flutter/material.dart';
import 'package:notes/Screen/create_notes_screen.dart';
import 'package:notes/Screen/login%20and%20signup/login_screen.dart';
import 'package:notes/Screen/notes_home_screen.dart';
import 'package:notes/Screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen()
    );
  }
}

