import 'package:flutter/material.dart';

class WorkerDashboardPage extends StatefulWidget {
  const WorkerDashboardPage({super.key});

  @override
  _WorkerDashboardPageState createState() => _WorkerDashboardPageState();
}

class _WorkerDashboardPageState extends State<WorkerDashboardPage> {
  // Dummy data for assigned sites, tasks, alerts, and geo-fencing
  final List<Map<String, dynamic>> _assignedSites = [
    {
      "name": "Sydney Opera House Site",
      "geoLocation": "Latitude: -33.8568, Longitude: 151.2153",
      "details": [
        {"building": "Building A", "levels": 5, "units": 10},
        {"building": "Building B", "levels": 3, "units": 8},
      ]
    },
    {
      "name": "Melbourne Construction Site",
      "geoLocation": "Latitude: -37.8136, Longitude: 144.9631",
      "details": [
        {"building": "Building C", "levels": 4, "units": 12}
      ]
    },
  ];

  final List<Map<String, dynamic>> _assignedTasks = [
    {
      "name": "Foundation Work",
      "description": "Complete the base structure of the building.",
      "priority": "High",
      "deadline": "2024-12-15",
    },
    {
      "name": "Roof Installation",
      "description": "Install roofing panels on Building B.",
      "priority": "Medium",
      "deadline": "2024-12-20",
    },
  ];

  final List<Map<String, dynamic>> _alerts = [
    {
      "title": "Safety Check",
      "message": "Safety check scheduled at 10 AM.",
      "urgency": "High",
      "timestamp": "2024-12-01 09:30 AM",
    },
    {
      "title": "Material Delay",
      "message": "Materials delayed by 2 hours.",
      "urgency": "Medium",
      "timestamp": "2024-12-01 08:00 AM",
    },
  ];

  final List<Map<String, String>> _geoFenceNotifications = [
    {
      "message": "You have entered the site.",
      "timestamp": "2024-12-01 08:05 AM",
    },
    {
      "message": "You have exited the site.",
      "timestamp": "2024-12-01 04:00 PM",
    },
  ];

  void _showSiteDetails(Map<String, dynamic> site) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(site["name"]),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Geo-location: ${site["geoLocation"]}"),
                const SizedBox(height: 10),
                const Text("Building Details:"),
                ...site["details"].map<Widget>((building) {
                  return Text(
                      "${building["building"]}: ${building["levels"]} levels, ${building["units"]} units");
                }).toList(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showTaskDetails(Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task["name"]),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Description: ${task["description"]}"),
              Text("Priority: ${task["priority"]}"),
              Text("Deadline: ${task["deadline"]}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showAlertDetails(Map<String, dynamic> alert) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(alert["title"]),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Message: ${alert["message"]}"),
              Text("Urgency: ${alert["urgency"]}"),
              Text("Timestamp: ${alert["timestamp"]}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showGeoFenceNotifications() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Geo-Fencing Notifications"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: _geoFenceNotifications.map<Widget>((notification) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                    "${notification["message"]} - ${notification["timestamp"]}"),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.gps_fixed),
            onPressed: _showGeoFenceNotifications,
            tooltip: "Geo-Fencing Notifications",
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Assigned Sites
              const Text(
                "Assigned Sites",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ..._assignedSites.map((site) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(site["name"]),
                    subtitle: Text("Geo-location: ${site["geoLocation"]}"),
                    trailing: const Icon(Icons.info_outline),
                    onTap: () => _showSiteDetails(site),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Assigned Tasks
              const Text(
                "Assigned Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ..._assignedTasks.map((task) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(task["name"]),
                    subtitle: Text("Priority: ${task["priority"]}"),
                    trailing: const Icon(Icons.info_outline),
                    onTap: () => _showTaskDetails(task),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Alerts
              const Text(
                "Alerts",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ..._alerts.map((alert) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(alert["title"]),
                    subtitle: Text("Urgency: ${alert["urgency"]}"),
                    trailing: const Icon(Icons.notifications_active),
                    onTap: () => _showAlertDetails(alert),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
