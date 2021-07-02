import 'package:flutter/material.dart';
import 'package:flutter_notes_app/pages/splash_screen.dart';
import 'package:flutter_notes_app/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes App',
      theme: Themes.light,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}