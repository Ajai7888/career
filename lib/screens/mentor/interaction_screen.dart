import 'package:flutter/material.dart';

class MentorInteractionScreen extends StatelessWidget {
  const MentorInteractionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final students = ["Ajai", "Kiran", "Sneha", "Ravi"];

    return Scaffold(
      appBar: AppBar(title: const Text("Mentor Interactions")),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(students[index]),
            subtitle: const Text("Career Guidance"),
            trailing: ElevatedButton(
              child: const Text("Chat"),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
