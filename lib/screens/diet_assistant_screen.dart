import 'package:flutter/material.dart';

class DietAssistantScreen extends StatefulWidget {
  const DietAssistantScreen({Key? key}) : super(key: key);

  @override
  State<DietAssistantScreen> createState() => _DietAssistantScreenState();
}

class _DietAssistantScreenState extends State<DietAssistantScreen> {
  final _formKey = GlobalKey<FormState>();
  String gender = 'Male';
  String goal = 'Lose Weight';
  String diet = 'No Preference';
  int age = 25;
  int weight = 70;
  int height = 170;
  String? aiPlan;
  bool loading = false;

  Future<void> getDietPlan() async {
    setState(() {
      loading = true;
      aiPlan = null;
    });
    // TODO: Integrate Gemini API here
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      aiPlan =
          'Sample Diet Plan:\n- Breakfast: Oatmeal with fruit\n- Lunch: Grilled chicken salad\n- Dinner: Steamed fish with veggies\n- Snacks: Greek yogurt, nuts';
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diet Assistant')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Answer a few questions to get your personalized diet plan:',
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
                value: goal,
                items: const [
                  DropdownMenuItem(
                    value: 'Lose Weight',
                    child: Text('Lose Weight'),
                  ),
                  DropdownMenuItem(
                    value: 'Gain Muscle',
                    child: Text('Gain Muscle'),
                  ),
                  DropdownMenuItem(value: 'Maintain', child: Text('Maintain')),
                ],
                onChanged: (v) => setState(() => goal = v ?? goal),
                decoration: const InputDecoration(labelText: 'Goal'),
              ),
              DropdownButtonFormField<String>(
                value: diet,
                items: const [
                  DropdownMenuItem(
                    value: 'No Preference',
                    child: Text('No Preference'),
                  ),
                  DropdownMenuItem(
                    value: 'Vegetarian',
                    child: Text('Vegetarian'),
                  ),
                  DropdownMenuItem(value: 'Vegan', child: Text('Vegan')),
                  DropdownMenuItem(value: 'Keto', child: Text('Keto')),
                ],
                onChanged: (v) => setState(() => diet = v ?? diet),
                decoration: const InputDecoration(labelText: 'Diet Type'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: loading ? null : getDietPlan,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text('Get Diet Plan'),
              ),
              const SizedBox(height: 24),
              if (aiPlan != null)
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(aiPlan!, style: const TextStyle(fontSize: 16)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
