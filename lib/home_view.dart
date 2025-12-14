import 'package:flutter/material.dart';
import 'package:google_maps_app/features/google_map/presentation/views/google_map_view.dart';
import 'package:google_maps_app/features/google_map/presentation/views/widgets/custom_google_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedAddress;
  double? selectedLat;
  double? selectedLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Picker Example")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: pickLocation,
              child: const Text("Pick Location from Map"),
            ),
            const SizedBox(height: 20),

            if (selectedAddress != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selected Address: $selectedAddress"),
                  const SizedBox(height: 10),
                  Text("Latitude: $selectedLat"),
                  Text("Longitude: $selectedLng"),
                ],
              )
          ],
        ),
      ),
    );
  }

  Future<void> pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GoogleMapView(),
      ),
    );

    if (result != null) {
      setState(() {
        selectedAddress = result["name"];
        selectedLat = result["lat"];
        selectedLng = result["lng"];
      });
    }
  }
}
