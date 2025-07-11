import 'package:flutter/material.dart';
import 'profile_form_screen.dart';

class TypeSelectionScreen extends StatelessWidget {
  const TypeSelectionScreen({super.key});

  void _selectStudentType(BuildContext context, String type) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ProfileFormScreen(studentType: type)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Student Type"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Are you a...",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.school, size: 28),
              label: const Text(
                "School Student",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[400],
                minimumSize: const Size.fromHeight(60),
              ),
              onPressed: () => _selectStudentType(context, "School"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.account_balance, size: 28),
              label: const Text(
                "College Student",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[400],
                minimumSize: const Size.fromHeight(60),
              ),
              onPressed: () => _selectStudentType(context, "College"),
            ),
          ],
        ),
      ),
    );
  }
}
