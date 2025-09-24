// File: enable_fingerprint_page.dart

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'customize_interest_page.dart'; // Importing CustomizeInterestPage

class EnableFingerprintPage extends StatefulWidget {
  const EnableFingerprintPage({Key? key}) : super(key: key);

  @override
  _EnableFingerprintPageState createState() => _EnableFingerprintPageState();
}

class _EnableFingerprintPageState extends State<EnableFingerprintPage> {
  final LocalAuthentication auth = LocalAuthentication();
  String _message = "Not authenticated";

  Future<void> _authenticate() async {
    try {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to enable fingerprint login',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      setState(() {
        _message = didAuthenticate
            ? "Fingerprint Enabled ✅"
            : "Authentication Failed ❌";
      });

      if (didAuthenticate) {
        // Navigate to next page after successful authentication
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomizeInterestPage(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _message = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomizeInterestPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ),

              // Illustration + Content
              Column(
                children: [
                  Image.network(
                    "https://img.icons8.com/ios-filled/200/8e24aa/fingerprint.png",
                    height: 120,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "STEP 1/7",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enable Fingerprint",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "If you enable touch ID, you don’t\nneed to enter your password when you login.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ],
              ),

              // Activate Button
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _authenticate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Activate",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(_message, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
