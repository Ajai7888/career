import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../shared/video_call_page.dart';

class InteractionScreen extends StatefulWidget {
  final String mentorId;
  final String studentId;

  const InteractionScreen({
    super.key,
    required this.mentorId,
    required this.studentId,
  });

  @override
  State<InteractionScreen> createState() => _InteractionScreenState();
}

class _InteractionScreenState extends State<InteractionScreen> {
  Map<String, dynamic>? mentorData;

  @override
  void initState() {
    super.initState();
    fetchMentorDetails();
  }

  Future<void> fetchMentorDetails() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.mentorId)
        .get();
    if (doc.exists) {
      setState(() => mentorData = doc.data());
    }
  }

  Future<void> registerInteractionAndStartCall() async {
    await FirebaseFirestore.instance.collection('interactions').add({
      'mentorId': widget.mentorId,
      'studentId': widget.studentId,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VideoCallPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mentorData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Interaction")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mentor: ${mentorData!['name'] ?? 'Unknown'}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text("Expertise: ${mentorData!['expertise'] ?? 'N/A'}"),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: registerInteractionAndStartCall,
                child: const Text("Register Interaction & Start Call"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
