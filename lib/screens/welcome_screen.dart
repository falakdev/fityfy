import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top logo
              const Icon(
                Icons.auto_awesome, // simple logo
                color: Colors.deepPurple,
                size: 60,
              ),
              const SizedBox(height: 20),

              // Title
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 24, color: Colors.black),
                  children: [
                    TextSpan(text: "Welcome to\n"),
                    TextSpan(
                      text: "Momotaro ",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: "UI Kit"),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Subtitle
              const Text(
                "The best UI Kit for your next health and fitness project!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 30),

              // Illustration
              Image.asset("lib/assets/images/welcome.png", height: 220),
              const SizedBox(height: 40),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Sign in text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have account? "),
                  GestureDetector(
                    onTap: () {
                      // Add navigation later
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
