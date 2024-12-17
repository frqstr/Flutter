import 'package:flutter/material.dart';
import 'pending_approval.dart';

class WorkerRegistrationPage extends StatefulWidget {
  const WorkerRegistrationPage({super.key});

  @override
  _WorkerRegistrationPageState createState() => _WorkerRegistrationPageState();
}

class _WorkerRegistrationPageState extends State<WorkerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _contractorIDController = TextEditingController();

  void _submitForm() {
    /*if (_formKey.currentState!.validate()) {
      // Dummy action: You can replace with backend logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Request submitted for ${_nameController.text} to join the contractor's team."),
        ),
      );

      // Clear fields
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _phoneController.clear();
      _contractorIDController.clear();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker Registration"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Register to Join Contractor's Team",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Please enter your name" : null,
                ),
                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) => value == null || value.length < 6
                      ? "Password must be at least 6 characters"
                      : null,
                ),
                const SizedBox(height: 16),

                // Phone Number Field
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.length < 10
                      ? "Please enter a valid phone number"
                      : null,
                ),
                const SizedBox(height: 16),

                // Contractor ID Field
                TextFormField(
                  controller: _contractorIDController,
                  decoration: const InputDecoration(
                    labelText: "Unique Contractor ID",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Please enter the contractor ID" : null,
                ),
                const SizedBox(height: 20),

                // Submit Button
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          // TODO: Uncomment to check and validate form
                          /*if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Registration Successful')),
                            );
                            // TODO: Handle registration logic
                          }*/
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WorkerPendingApprovalPage()),
                          );

                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _contractorIDController.dispose();
    super.dispose();
  }
}
