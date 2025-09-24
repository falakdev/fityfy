import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/phone_number_screen.dart'; // import the phone number screen
import 'screens/verify_number_screen.dart';
import 'screens/profile_pic_page.dart';
import 'screens/enable_fingerprint_page.dart';
import 'screens/customize_interest_page.dart';
import 'screens/main_nav.dart'; // Import MainNav for routing to the main navigation bar after onboarding
import 'screens/diet_assistant_screen.dart';
import 'screens/calorie_calculator_screen.dart';

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
        '/verify': (context) => const VerifyNumberScreen(phoneNumber: ""),
        '/profile_pic': (context) => const ProfilePicturePage(),
        '/fingerprint': (context) => const EnableFingerprintPage(),
        '/interests': (context) => const CustomizeInterestPage(),
        '/dashboard': (context) => const MainNav(),
        '/main_nav': (context) => const MainNav(), // Route for MainNav
        '/diet_assistant': (context) => const DietAssistantScreen(),
        '/calorie_calculator': (context) => const CalorieCalculatorScreen(),
      },
    );
  }
}
