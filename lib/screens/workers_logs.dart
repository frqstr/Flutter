import 'package:flutter/material.dart';

class WorkerAttendancePage extends StatefulWidget {
  const WorkerAttendancePage({super.key});

  @override
  _WorkerAttendancePageState createState() => _WorkerAttendancePageState();
}

class _WorkerAttendancePageState extends State<WorkerAttendancePage> {
  final Map<String, List<Map<String, dynamic>>> _weeklyAttendance = {
    "2024-12-10": [
      {
        "workerName": "John Doe",
        "siteName": "Sydney Opera House Site",
        "checkIn": "08:00",
        "checkOut": "16:00",
        "hoursWorked": 8,
      },
      {
        "workerName": "Jane Smith",
        "siteName": "Melbourne Construction Site",
        "checkIn": "09:00",
        "checkOut": "17:30",
        "hoursWorked": 8.5,
      },
    ],
    "2024-12-11": [
      {
        "workerName": "John Doe",
        "siteName": "Sydney Opera House Site",
        "checkIn": "07:45",
        "checkOut": "15:45",
        "hoursWorked": 8,
      },
      {
        "workerName": "Jane Smith",
        "siteName": "Melbourne Construction Site",
        "checkIn": "09:30",
        "checkOut": "18:00",
        "hoursWorked": 8.5,
      },
    ],
    "2024-12-12": [
      {
        "workerName": "John Doe",
        "siteName": "Sydney Opera House Site",
        "checkIn": "08:15",
        "checkOut": "15:45",
        "hoursWorked": 7.5,
      },
    ],
  };

  DateTime _selectedWeek = DateTime(2024, 12, 10);

  List<String> get _datesInWeek {
    final startOfWeek = _selectedWeek.subtract(Duration(days: _selectedWeek.weekday - 1));
    return List.generate(7, (index) {
      final date = startOfWeek.add(Duration(days: index));
      return date.toString().split(' ')[0];
    });
  }

  List<Map<String, dynamic>> _getWorkerDetails(String workerName) {
    List<Map<String, dynamic>> details = [];
    for (var date in _datesInWeek) {
      if (_weeklyAttendance[date] != null) {
        for (var log in _weeklyAttendance[date]!) {
          if (log["workerName"] == workerName) {
            details.add({"date": date, ...log});
          }
        }
      }
    }
    return details;
  }

  double _calculateWeeklyHours(String workerName) {
    double totalHours = 0.0;
    for (var date in _datesInWeek) {
      if (_weeklyAttendance[date] != null) {
        for (var log in _weeklyAttendance[date]!) {
          if (log["workerName"] == workerName) {
            totalHours += log["hoursWorked"];
          }
        }
      }
    }
    return totalHours;
  }

  void _showWorkerDetails(String workerName) {
    final details = _getWorkerDetails(workerName);
    final totalHours = _calculateWeeklyHours(workerName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("$workerName's Weekly Log"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Weekly Hours: ${totalHours.toStringAsFixed(1)} hours",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Divider(),
                ...details.map((log) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date: ${log["date"]}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Site: ${log["siteName"]}"),
                        Text("Check-in: ${log["checkIn"]}"),
                        Text("Check-out: ${log["checkOut"]}"),
                        Text("Hours Worked: ${log["hoursWorked"]} hours"),
                        const Divider(),
                      ],
                    ),
                  );
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

  void _selectWeek() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedWeek,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedWeek = pickedDate.subtract(Duration(days: pickedDate.weekday - 1));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker Attendance"),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _selectWeek,
            tooltip: "Select Week",
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: _datesInWeek.map((date) {
              final logs = _weeklyAttendance[date] ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Separator
                  Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      date,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Logs for the Date
                  if (logs.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("No attendance records for this day."),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text(log["workerName"]),
                            subtitle: Text("Site: ${log["siteName"]}"),
                            onTap: () => _showWorkerDetails(log["workerName"]),
                          ),
                        );
                      },
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
