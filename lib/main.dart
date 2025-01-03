import 'package:flutter/material.dart';
import 'package:projectlab/screen/login_screen.dart';
import 'package:projectlab/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vidio Tape Store',
      home: const LoginScreen(),
      routes: {
        'home': (context) => const HomeScreen(),
      },
    );
  }
}
