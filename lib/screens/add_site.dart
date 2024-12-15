import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class ConstructionSitePage extends StatefulWidget {
  const ConstructionSitePage({super.key});

  @override
  _ConstructionSitePageState createState() => _ConstructionSitePageState();
}

class _ConstructionSitePageState extends State<ConstructionSitePage> {
  final List<Map<String, dynamic>> _sites = [
    {
      "siteName": "Sydney Opera House Site",
      "location": LatLng(-33.8567844, 151.2152967),
      "radius": 100,
      "buildings": [
        {"name": "Building A", "levels": 5, "unitsPerLevel": 10},
      ],
    },
  ];

  final TextEditingController _siteNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _buildingNameController = TextEditingController();
  final TextEditingController _levelsController = TextEditingController();
  final TextEditingController _unitsController = TextEditingController();

  LatLng? _selectedLocation;
  double _radius = 100;
  List<Map<String, dynamic>> _buildings = [];

  Future<void> _getCoordinatesFromAddress() async {
    if (_addressController.text.isNotEmpty) {
      try {
        List<Location> locations =
        await locationFromAddress(_addressController.text);
        if (locations.isNotEmpty) {
          setState(() {
            _selectedLocation =
                LatLng(locations[0].latitude, locations[0].longitude);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to get location: $e')),
        );
      }
    }
  }

  void _addSite() {
    if (_siteNameController.text.isNotEmpty && _selectedLocation != null) {
      setState(() {
        _sites.add({
          "siteName": _siteNameController.text,
          "location": _selectedLocation,
          "radius": _radius,
          "buildings": _buildings,
        });
        _siteNameController.clear();
        _addressController.clear();
        _buildings = [];
        _selectedLocation = null;
        _radius = 100;
      });
      Navigator.of(context).pop();
    }
  }

  void _addBuilding() {
    if (_buildingNameController.text.isNotEmpty &&
        _levelsController.text.isNotEmpty &&
        _unitsController.text.isNotEmpty) {
      setState(() {
        _buildings.add({
          "name": _buildingNameController.text,
          "levels": int.parse(_levelsController.text),
          "unitsPerLevel": int.parse(_unitsController.text),
        });
        _buildingNameController.clear();
        _levelsController.clear();
        _unitsController.clear();
      });
    }
  }

  void _openAddSiteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Site"),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _siteNameController,
                    decoration: const InputDecoration(labelText: "Site Name"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: "Address"),
                    onSubmitted: (_) => _getCoordinatesFromAddress(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _getCoordinatesFromAddress,
                    child: const Text("Get Location from Address"),
                  ),
                  const SizedBox(height: 10),
                  const Text("Select Location on Map"),
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(-33.8688, 151.2093), // Sydney, Australia
                        zoom: 10,
                      ),
                      onTap: (LatLng location) {
                        setState(() {
                          _selectedLocation = location;
                        });
                      },
                      markers: _selectedLocation != null
                          ? {
                        Marker(
                          markerId: const MarkerId("selectedLocation"),
                          position: _selectedLocation!,
                        ),
                      }
                          : {},
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration:
                    const InputDecoration(labelText: "Radius (meters)"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _radius = double.tryParse(value) ?? 100;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text("Building Details"),
                  SizedBox(
                    height: 150, // Fixed height for ListView
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _buildings.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_buildings[index]["name"]),
                          subtitle: Text(
                              "${_buildings[index]["levels"]} levels, ${_buildings[index]["unitsPerLevel"]} units/level"),
                        );
                      },
                    ),
                  ),
                  TextField(
                    controller: _buildingNameController,
                    decoration:
                    const InputDecoration(labelText: "Building Name"),
                  ),
                  TextField(
                    controller: _levelsController,
                    decoration: const InputDecoration(labelText: "Levels"),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _unitsController,
                    decoration:
                    const InputDecoration(labelText: "Units Per Level"),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: _addBuilding,
                    child: const Text("Add Building"),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: _addSite,
              child: const Text("Save Site"),
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
        title: const Text("Construction Sites"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _sites.length,
          itemBuilder: (context, index) {
            final site = _sites[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(site["siteName"]),
                subtitle: Text(
                  "Location: ${site["location"].latitude}, ${site["location"].longitude}\n"
                      "Radius: ${site["radius"]} meters",
                ),
                trailing: const Icon(Icons.location_on),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddSiteDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
