import 'package:flutter/material.dart';

class CareerPortalScreen extends StatelessWidget {
  const CareerPortalScreen({super.key});

  final opportunities = const [
    {
      "company": "Google",
      "position": "Software Engineering Intern",
      "location": "Bangalore, India",
    },
    {
      "company": "Deloitte",
      "position": "Data Analyst - Fresher",
      "location": "Mumbai, India",
    },
    {
      "company": "TCS",
      "position": "Business Process Trainee",
      "location": "Remote",
    },
    {
      "company": "Zoho",
      "position": "UI/UX Designer",
      "location": "Chennai, India",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Career Opportunities")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: opportunities.length,
        itemBuilder: (context, index) {
          final job = opportunities[index];
          return Card(
            child: ListTile(
              title: Text(
                job["position"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${job["company"]!} • ${job["location"]!}"),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text("Apply"),
              ),
            ),
          );
        },
      ),
    );
  }
}
