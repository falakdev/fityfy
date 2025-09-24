import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1511367461989-f85a21fda167?auto=format&fit=crop&w=200&q=80',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'John Doe',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Fitness Enthusiast',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(Icons.settings, color: Colors.deepPurple),
            title: Text('Settings'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
      ],
    );
  }
}
