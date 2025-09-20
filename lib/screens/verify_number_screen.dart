import 'package:flutter/material.dart';

class VerifyNumberScreen extends StatefulWidget {
  final String phoneNumber; // Pass phone number dynamically

  const VerifyNumberScreen({super.key, required this.phoneNumber});

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  List<String> otp = ["", "", "", ""]; // Store entered digits

  void _onNumberTap(String number) {
    setState(() {
      for (int i = 0; i < otp.length; i++) {
        if (otp[i].isEmpty) {
          otp[i] = number;
          break;
        }
      }
    });
  }

  void _onBackspace() {
    setState(() {
      for (int i = otp.length - 1; i >= 0; i--) {
        if (otp[i].isNotEmpty) {
          otp[i] = "";
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final topHeight = constraints.maxHeight * 0.48;
              return Column(
                children: [
                  // Top content scaled into fixed area
                  SizedBox(
                    height: topHeight,
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: constraints.maxWidth - 40, // account for padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.black87,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                const Spacer(),
                                Container(
                                  width: 120,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple.withAlpha(230),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const Spacer(flex: 2),
                              ],
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              "STEP 1/7",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Verify your number",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "We’ll text you on ${widget.phoneNumber}.",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(otp.length, (i) {
                                final digit = otp[i];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: SizedBox(
                                    width: 36,
                                    height: 48,
                                    child: Center(
                                      child: digit.isEmpty
                                          ? Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                color: Colors.deepPurple
                                                    .withAlpha(64),
                                                shape: BoxShape.circle,
                                              ),
                                            )
                                          : Text(
                                              digit,
                                              style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Send me a new code",
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 4,
                                ),
                                onPressed: otp.every((d) => d.isNotEmpty)
                                    ? () {}
                                    : null,
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Keypad fills remaining area
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 14,
                              childAspectRatio: 1.45,
                            ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          if (index < 9) {
                            return _buildNumberButton((index + 1).toString());
                          } else if (index == 9) {
                            return const SizedBox.shrink();
                          } else if (index == 10) {
                            return _buildNumberButton("0");
                          } else {
                            return _buildBackspaceButton();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return InkWell(
      onTap: () => _onNumberTap(number),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return InkWell(
      onTap: _onBackspace,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.backspace_outlined,
            size: 22,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
