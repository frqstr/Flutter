import 'package:flutter/material.dart';
import 'tasks.dart';
import 'add_worker.dart';
import 'add_site.dart';
import 'send_alerts.dart';
import 'workers_logs.dart';
import 'assign_work.dart';

class ContractorDashboard extends StatelessWidget {
  const ContractorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    const num id = 234234;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contractor Dashboard"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome, Contractor!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "UID $id",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.task_alt, color: Colors.yellow),
                  title: const Text("Overview of Tasks"),
                  subtitle: const Text("View and manage all tasks."),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to Tasks Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TaskManagementPage()),
                    );
                  },
                ),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.group, color: Colors.blue),
                  title: const Text("Workers"),
                  subtitle: const Text("View and manage workers."),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to Workers Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WorkerApprovalPage()),
                    );

                  },
                ),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.green),
                  title: const Text("Sites"),
                  subtitle: const Text("View and manage construction sites."),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to Sites Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ConstructionSitePage()),
                    );
                  },
                ),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.red),
                  title: const Text("Alerts"),
                  subtitle: const Text("View important alerts."),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AlertsPage()),
                    );

                    // Navigate to Alerts Page
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                        backgroundColor: Colors.grey[700],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WorkerAttendancePage()),
                        );
                        // Navigate to Worker Attendance Logs
                      },
                      icon: const Icon(Icons.list_alt),
                      label: const Text("View Worker Attendance Logs"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                        backgroundColor: Colors.green[700],
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerAssignmentPage()));
                        // Navigate to Worker Attendance Logs
                      },
                      icon: const Icon(Icons.list_alt),
                      label: const Text("Assign task and sites"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dashboardButton(BuildContext context, String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
