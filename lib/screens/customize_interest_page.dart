import 'package:flutter/material.dart';

class CustomizeInterestPage extends StatefulWidget {
  const CustomizeInterestPage({Key? key}) : super(key: key);

  @override
  State<CustomizeInterestPage> createState() => _CustomizeInterestPageState();
}

class _CustomizeInterestPageState extends State<CustomizeInterestPage> {
  // List of interests
  final List<Map<String, dynamic>> interests = [
    {
      "title": "Nutrition",
      "icon":
          "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=80&q=80",
    },
    {
      "title": "Organic",
      "icon":
          "https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=80&q=80",
    },
    {
      "title": "Meditation",
      "icon":
          "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=80&q=80",
    },
    {
      "title": "Sports",
      "icon":
          "https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=80&q=80",
    },
    {
      "title": "Smoke Free",
      "icon":
          "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=80&q=80",
    },
    {
      "title": "Sleep",
      "icon":
          "https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=80&q=80",
    },
    {
      "title": "Health",
      "icon":
          "https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?auto=format&fit=crop&w=80&q=80",
    },
    {
      "title": "Running",
      "icon":
          "https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=80&q=80",
    },
    {
      "title": "Vegan",
      "icon":
          "https://images.unsplash.com/photo-1464306076886-debca5e8a6b0?auto=format&fit=crop&w=80&q=80",
    },
  ];

  // Track selected interests
  List<String> selected = [];

  void toggleInterest(String title) {
    setState(() {
      if (selected.contains(title)) {
        selected.remove(title);
      } else {
        selected.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.black),
                  TextButton(
                    onPressed: () {
                      // Skip action
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Step progress indicator
              LinearProgressIndicator(
                value: 0.33,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
                color: Colors.purple,
                backgroundColor: Colors.purple.withOpacity(0.2),
              ),

              const SizedBox(height: 16),
              const Text("STEP 1/3", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              const Text(
                "Time to customize\nyour interest",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // Interests Grid
              Expanded(
                child: GridView.builder(
                  itemCount: interests.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final item = interests[index];
                    final isSelected = selected.contains(item["title"]);

                    return GestureDetector(
                      onTap: () => toggleInterest(item["title"]),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.purple.shade100
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? Colors.purple
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              item["icon"],
                              height: 40,
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item["title"],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.purple
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Continue action with selected interests
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
