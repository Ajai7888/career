import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class ProfileFormScreen extends StatefulWidget {
  final String studentType; // "School" or "College"

  const ProfileFormScreen({super.key, required this.studentType});

  @override
  State<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _showBottomSheet() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.psychology_alt_rounded,
                  size: 48,
                  color: Color(0xFF6A1B9A),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Let our AI analyze your profile and suggest the right career path!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _showProfileSummary,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7B1FA2), Color(0xFFE040FB)],
                          ),
                        ),
                        child: InkWell(
                          onTap: _goToDashboard,
                          borderRadius: BorderRadius.circular(12),
                          child: const Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void _showProfileSummary() {
    Navigator.pop(context); // close bottom sheet

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your Profile Summary"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _formData.entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("${e.key.toUpperCase()}: ${e.value}"),
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _goToDashboard() async {
    Navigator.pop(context); // close bottom sheet
    await Future.delayed(const Duration(seconds: 2)); // simulate delay
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const StudentDashboardScreen()),
    );
  }

  Widget _buildTextField(
    String label,
    String key, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) =>
            (value == null || value.isEmpty) ? "Enter $label" : null,
        onSaved: (value) => _formData[key] = value!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSchool = widget.studentType == "School";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text("Profile (${widget.studentType})"),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Complete Your Profile",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField("Full Name", "name"),
                  _buildTextField(
                    "Age",
                    "age",
                    keyboardType: TextInputType.number,
                  ),
                  isSchool
                      ? _buildTextField("Standard (e.g. 10th)", "standard")
                      : _buildTextField("Degree (e.g. B.Tech)", "degree"),
                  _buildTextField("Native Place", "native"),
                  _buildTextField("Skills (comma-separated)", "skills"),
                  _buildTextField("Known Languages", "languages"),
                  _buildTextField("Interested Domain", "domain"),
                  _buildTextField(
                    "Mobile Number",
                    "mobile",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7B1FA2), Color(0xFFE040FB)],
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: _showBottomSheet,
                      child: const Center(
                        child: Text(
                          "Proceed",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
