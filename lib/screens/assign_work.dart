import 'package:flutter/material.dart';

class WorkerAssignmentPage extends StatefulWidget {
  const WorkerAssignmentPage({super.key});

  @override
  _WorkerAssignmentPageState createState() => _WorkerAssignmentPageState();
}

class _WorkerAssignmentPageState extends State<WorkerAssignmentPage> {
  final List<Map<String, String>> _workers = [
    {"name": "John Doe", "id": "W001"},
    {"name": "Jane Smith", "id": "W002"},
    {"name": "Mike Johnson", "id": "W003"},
  ];

  final List<Map<String, String>> _sites = [
    {"name": "Sydney Opera House Site", "id": "S001"},
    {"name": "Melbourne Construction Site", "id": "S002"},
  ];

  final List<Map<String, String>> _tasks = [
    {"name": "Foundation Work", "id": "T001"},
    {"name": "Electrical Wiring", "id": "T002"},
    {"name": "Roof Installation", "id": "T003"},
  ];

  final List<Map<String, String>> _assignments = [];

  String? _selectedWorker;
  String? _selectedSite;
  String? _selectedTask;
  final TextEditingController _assignmentDetailsController =
  TextEditingController();

  void _saveAssignment() {
    if (_selectedWorker != null &&
        _selectedSite != null &&
        _selectedTask != null &&
        _assignmentDetailsController.text.isNotEmpty) {
      setState(() {
        _assignments.add({
          "worker": _selectedWorker!,
          "site": _selectedSite!,
          "task": _selectedTask!,
          "details": _assignmentDetailsController.text,
        });

        // Clear fields after saving
        _selectedWorker = null;
        _selectedSite = null;
        _selectedTask = null;
        _assignmentDetailsController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Assignment saved successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Workers"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Assign Workers to Sites and Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Worker Dropdown
              DropdownButtonFormField<String>(
                value: _selectedWorker,
                decoration: const InputDecoration(
                  labelText: "Select Worker",
                  border: OutlineInputBorder(),
                ),
                items: _workers
                    .map((worker) => DropdownMenuItem<String>(
                  value: worker["name"],
                  child: Text(worker["name"]!),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedWorker = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Site Dropdown
              DropdownButtonFormField<String>(
                value: _selectedSite,
                decoration: const InputDecoration(
                  labelText: "Select Site",
                  border: OutlineInputBorder(),
                ),
                items: _sites
                    .map((site) => DropdownMenuItem<String>(
                  value: site["name"],
                  child: Text(site["name"]!),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSite = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Task Dropdown
              DropdownButtonFormField<String>(
                value: _selectedTask,
                decoration: const InputDecoration(
                  labelText: "Select Task",
                  border: OutlineInputBorder(),
                ),
                items: _tasks
                    .map((task) => DropdownMenuItem<String>(
                  value: task["name"],
                  child: Text(task["name"]!),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTask = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Assignment Details
              TextField(
                controller: _assignmentDetailsController,
                decoration: const InputDecoration(
                  labelText: "Assignment Details",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // Save Assignment Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAssignment,
                  child: const Text(
                    "Save Assignment",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // List of Assignments
              const Text(
                "Saved Assignments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (_assignments.isEmpty)
                const Center(
                  child: Text("No assignments saved yet."),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _assignments.length,
                  itemBuilder: (context, index) {
                    final assignment = _assignments[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(assignment["worker"]!),
                        subtitle: Text(
                          "Site: ${assignment["site"]}\n"
                              "Task: ${assignment["task"]}\n"
                              "Details: ${assignment["details"]}",
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
