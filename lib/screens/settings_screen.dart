import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Settings',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(Icons.notifications, color: Colors.deepPurple),
            title: Text('Notifications'),
            trailing: Switch(value: true, onChanged: (v) {}),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(Icons.palette, color: Colors.deepPurple),
            title: Text('Theme'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(Icons.info, color: Colors.deepPurple),
            title: Text('About'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
      ],
    );
  }
}
