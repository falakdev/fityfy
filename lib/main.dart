import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momotaro UI Kit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arial', primarySwatch: Colors.deepPurple),
      home: const WelcomeScreen(),
    );
  }
}
