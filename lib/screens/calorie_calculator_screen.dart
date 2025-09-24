import 'package:flutter/material.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  const CalorieCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalorieCalculatorScreen> createState() =>
      _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  int age = 25;
  int weight = 70;
  int height = 170;
  String gender = 'Male';
  String activity = 'Light';
  double? calories;

  void calculateCalories() {
    double bmr = gender == 'Male'
        ? 88.36 + (13.4 * weight) + (4.8 * height) - (5.7 * age)
        : 447.6 + (9.2 * weight) + (3.1 * height) - (4.3 * age);
    double multiplier = 1.375;
    if (activity == 'Sedentary') multiplier = 1.2;
    if (activity == 'Moderate') multiplier = 1.55;
    if (activity == 'Active') multiplier = 1.725;
    calories = bmr * multiplier;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calorie Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Calculate your daily calorie needs:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Age'),
              initialValue: age.toString(),
              keyboardType: TextInputType.number,
              onChanged: (v) => age = int.tryParse(v) ?? age,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              initialValue: weight.toString(),
              keyboardType: TextInputType.number,
              onChanged: (v) => weight = int.tryParse(v) ?? weight,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Height (cm)'),
              initialValue: height.toString(),
              keyboardType: TextInputType.number,
              onChanged: (v) => height = int.tryParse(v) ?? height,
            ),
            DropdownButtonFormField<String>(
              value: gender,
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
              ],
              onChanged: (v) => setState(() => gender = v ?? gender),
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            DropdownButtonFormField<String>(
              value: activity,
              items: const [
                DropdownMenuItem(
                  value: 'Sedentary',
                  child: Text('Sedentary (little/no exercise)'),
                ),
                DropdownMenuItem(
                  value: 'Light',
                  child: Text('Light (1-3 days/week)'),
                ),
                DropdownMenuItem(
                  value: 'Moderate',
                  child: Text('Moderate (3-5 days/week)'),
                ),
                DropdownMenuItem(
                  value: 'Active',
                  child: Text('Active (6-7 days/week)'),
                ),
              ],
              onChanged: (v) => setState(() => activity = v ?? activity),
              decoration: const InputDecoration(labelText: 'Activity Level'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: calculateCalories,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 24),
            if (calories != null)
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Your daily calorie needs: ${calories!.toStringAsFixed(0)} kcal',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
