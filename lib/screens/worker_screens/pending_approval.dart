import 'package:flutter/material.dart';
import 'approved_dash.dart';

class WorkerPendingApprovalPage extends StatefulWidget {
  const WorkerPendingApprovalPage({super.key});

  @override
  _WorkerPendingApprovalPageState createState() =>
      _WorkerPendingApprovalPageState();
}

class _WorkerPendingApprovalPageState extends State<WorkerPendingApprovalPage> {
  final TextEditingController _contractorIDController = TextEditingController();
  bool _isResubmitting = false;

  void _resubmitRequest() {
    if (_contractorIDController.text.isNotEmpty) {
      setState(() {
        _isResubmitting = true;
      });

      // Simulate a delay for resubmission
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isResubmitting = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Request resubmitted with Contractor ID: ${_contractorIDController.text}",
            ),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid Contractor ID.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker Dashboard"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.hourglass_empty,
                  size: 100,
                  color: Colors.amber,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Your request is pending approval.",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please wait for your contractor to approve your request. If needed, you can update your Contractor ID and resubmit.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Contractor ID Field
                TextField(
                  controller: _contractorIDController,
                  decoration: const InputDecoration(
                    labelText: "Update Contractor ID",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.edit),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),

                // Resubmit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isResubmitting ? null : _resubmitRequest,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: _isResubmitting
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Resubmit Request",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        // TODO: Remove this bypass button in future
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerDashboardPage()));


                      },
                      child: const Text(
                        'Bypass',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ],
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
    _contractorIDController.dispose();
    super.dispose();
  }
}
