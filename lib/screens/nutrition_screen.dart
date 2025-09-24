import 'package:flutter/material.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 24),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(Icons.breakfast_dining, color: Colors.green),
            title: Text('Healthy Breakfast'),
            subtitle: Text('Oats, fruits, nuts'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(Icons.lunch_dining, color: Colors.green),
            title: Text('Lunch Ideas'),
            subtitle: Text('Salads, lean protein'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(Icons.dinner_dining, color: Colors.green),
            title: Text('Dinner Tips'),
            subtitle: Text('Light & nutritious'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
      ],
    );
  }
}
