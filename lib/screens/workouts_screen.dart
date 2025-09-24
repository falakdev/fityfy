import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _WorkoutsList();
  }
}

class _WorkoutsList extends StatefulWidget {
  @override
  State<_WorkoutsList> createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<_WorkoutsList> {
  List<dynamic> workouts = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchWorkouts();
  }

  Future<void> fetchWorkouts() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      // Using JSONPlaceholder for dummy data
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5'),
      );
      if (response.statusCode == 200) {
        workouts = json.decode(response.body);
      } else {
        error = 'Failed to load workouts.';
      }
    } catch (e) {
      error = e.toString();
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return Center(
        child: Text(error!, style: const TextStyle(color: Colors.red)),
      );
    }
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
        ...workouts.map(
          (w) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.fitness_center, color: Colors.deepPurple),
              title: Text(w['title'] ?? ''),
              subtitle: Text(w['body'] ?? ''),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}
