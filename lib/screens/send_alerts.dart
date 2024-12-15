import 'package:flutter/material.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  final TextEditingController _alertMessageController = TextEditingController();
  String _selectedUrgency = "Free";
  String? _selectedRecipient;

  // Dummy data for sites
  final List<Map<String, dynamic>> _sites = [
    {"siteName": "Sydney Opera House Site", "workers": ["John Doe", "Jane Smith"]},
    {"siteName": "Melbourne Construction Site", "workers": ["Mike Johnson", "Sara Lee"]},
  ];

  // Dummy data for sent alerts
  final List<Map<String, dynamic>> _sentAlerts = [
    {
      "message": "Site inspection required immediately.",
      "urgency": "Urgent",
      "recipient": "Sydney Opera House Site",
    },
    {
      "message": "Safety meeting at 10 AM.",
      "urgency": "Priority",
      "recipient": "Melbourne Construction Site",
    },
    {
      "message": "Safety meeting at 10 AM.",
      "urgency": "Priority",
      "recipient": "Melbourne Construction Site",
    },
    {
      "message": "Safety meeting at 10 AM.",
      "urgency": "Priority",
      "recipient": "Melbourne Construction Site",
    },
    {
      "message": "Safety meeting at 10 AM.",
      "urgency": "Priority",
      "recipient": "Melbourne Construction Site",
    },
    {
      "message": "Site inspection required immediately.",
      "urgency": "Urgent",
      "recipient": "Sydney Opera House Site",
    },
    {
      "message": "Safety meeting at 10 AM.",
      "urgency": "Priority",
      "recipient": "Melbourne Construction Site",
    },
    {
      "message": "Safety meeting at 10 AM.",
      "urgency": "Priority",
      "recipient": "Melbourne Construction Site",
    },
    {
      "message": "Safety meeting at 10 AM.",
      "urgency": "Priority",
      "recipient": "Melbourne Construction Site",
    },
    {
      "message": "Safety meeting at 10 AM.",
      "urgency": "Priority",
      "recipient": "Melbourne Construction Site",
    },
  ];

  void _sendAlert() {
    if (_alertMessageController.text.isNotEmpty && _selectedRecipient != null) {
      setState(() {
        _sentAlerts.add({
          "message": _alertMessageController.text,
          "urgency": _selectedUrgency,
          "recipient": _selectedRecipient,
        });
        // Clear fields after sending
        _alertMessageController.clear();
        _selectedUrgency = "Free";
        _selectedRecipient = null;
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Alert Sent"),
            content: const Text("Your alert has been successfully broadcast."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      // Show error message if fields are incomplete
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields before sending.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Alerts"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Broadcast New Alert",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Alert Message Input
              TextField(
                controller: _alertMessageController,
                decoration: const InputDecoration(
                  labelText: "Alert Message",
                  hintText: "Enter the alert message",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // Urgency Level Dropdown
              DropdownButtonFormField<String>(
                value: _selectedUrgency,
                decoration: const InputDecoration(
                  labelText: "Urgency Level",
                  border: OutlineInputBorder(),
                ),
                items: ["Free", "Priority", "Urgent"]
                    .map((urgency) => DropdownMenuItem<String>(
                  value: urgency,
                  child: Text(urgency),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUrgency = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Recipient Dropdown
              DropdownButtonFormField<String>(
                value: _selectedRecipient,
                decoration: const InputDecoration(
                  labelText: "Select Site/Team",
                  border: OutlineInputBorder(),
                ),
                items: _sites
                    .map((site) => DropdownMenuItem<String>(
                  value: site["siteName"] as String,
                  child: Text(site["siteName"]),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRecipient = value!;
                  });
                },
              ),

              const SizedBox(height: 30),

              // Send Alert Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: _sendAlert,
                  child: const Text(
                    "Send Alert",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Sent Alerts Section
              const Text(
                "Sent Alerts",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _sentAlerts.length,
                itemBuilder: (context, index) {
                  final alert = _sentAlerts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(alert["message"]),
                      subtitle: Text(
                        "Urgency: ${alert["urgency"]}\nRecipient: ${alert["recipient"]}",
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
