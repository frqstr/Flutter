import 'package:flutter/material.dart';

class WorkerApprovalPage extends StatefulWidget {
  const WorkerApprovalPage({super.key});

  @override
  _WorkerApprovalPageState createState() => _WorkerApprovalPageState();
}

class _WorkerApprovalPageState extends State<WorkerApprovalPage> {
  // Dummy data for requested workers
  final List<Map<String, dynamic>> _requestedWorkers = [
    {"name": "John Doe", "id": "W12345", "status": "Pending"},
    {"name": "Jane Smith", "id": "W67890", "status": "Pending"},
  ];

  // Dummy data for added workers
  final List<Map<String, dynamic>> _addedWorkers = [
    {"name": "Mike Johnson", "id": "W11223", "status": "Approved"},
    {"name": "Sara Lee", "id": "W33445", "status": "Approved"},
  ];

  // Function to approve a worker
  void _approveWorker(int index) {
    setState(() {
      _addedWorkers.add(_requestedWorkers[index]);
      _requestedWorkers.removeAt(index);
    });
  }

  // Function to reject a worker
  void _rejectWorker(int index) {
    setState(() {
      _requestedWorkers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker Management"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Requested Workers Section
              const Text(
                "Requested Workers",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _requestedWorkers.isEmpty
                  ? const Center(
                child: Text(
                  "No worker requests at the moment.",
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _requestedWorkers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(_requestedWorkers[index]["name"]),
                      subtitle: Text("ID: ${_requestedWorkers[index]["id"]}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () {
                              _approveWorker(index);
                            },
                            tooltip: "Approve",
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              _rejectWorker(index);
                            },
                            tooltip: "Reject",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Added Workers Section
              const Text(
                "Added Workers",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _addedWorkers.isEmpty
                  ? const Center(
                child: Text(
                  "No workers added to the team yet.",
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _addedWorkers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(_addedWorkers[index]["name"]),
                      subtitle: Text("ID: ${_addedWorkers[index]["id"]}"),
                      trailing: const Text(
                        "Approved",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
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
