import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/phone_number_screen.dart'; // import the phone number screen

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
      // first page shown when app opens
      home: const WelcomeScreen(),

      // optional: define routes for navigation
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/phone': (context) => const PhoneNumberScreen(),
      },
    );
  }
}
