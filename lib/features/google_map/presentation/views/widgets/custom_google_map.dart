import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:google_maps_app/core/services/location_service.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  GoogleMapController? googleMapController;
  late LocationService locationService;

  LatLng? selectedLatLng;
  String selectedAddress = "Move the map to select a location...";

  @override
  void initState() {
    super.initState();
    locationService = LocationService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(30.0444, 31.2357), // القاهرة كبداية آمنة
              zoom: 14,
            ),
            onMapCreated: (controller) {
              googleMapController = controller;
              _goToUserLocation();
            },

            onCameraMove: (position) {
              selectedLatLng = position.target;
            },

            onCameraIdle: () {
              if (selectedLatLng != null) {
                Future.delayed(
                  const Duration(milliseconds: 250),
                  () => _getAddress(selectedLatLng!),
                );
              }
            },
          ),

          const Center(
            child: Icon(Icons.location_pin, size: 45, color: Colors.red),
          ),

          Positioned(
            bottom: 30,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    selectedAddress,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    if (selectedLatLng != null) {
                      Navigator.pop(context, {
                        "name": selectedAddress,
                        "lat": selectedLatLng!.latitude,
                        "lng": selectedLatLng!.longitude,
                      });
                    }
                  },
                  child: const Text("اختيار هذا المكان"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToUserLocation() async {
    final loc = await locationService.getLocationData();

    googleMapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(loc.latitude!, loc.longitude!),
        16,
      ),
    );
  }

  Future<void> _getAddress(LatLng latlng) async {
    try {
      final address = await GeocodingApiService.getAddressFromLatLng(
        latlng.latitude,
        latlng.longitude,
      );

      setState(() {
        selectedAddress = address;
      });
    } catch (e) {
      setState(() {
        selectedAddress = "Unable to fetch address";
      });
      print("GEOCODING ERROR → $e");
    }
  }
}

class GeocodingApiService {
  static const String apiKey = "AIzaSyAt4YfkHwNmHKhtVi43zfYx_bSneiN022U"; // ← حط API KEY هنا

  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    final url = Uri.parse(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
       log("Failed to call Google API");
    }

    final data = jsonDecode(response.body);

    if (data["status"] != "OK") {
       log("Google API Error: ${data['status']}");
    }

    return data["results"][0]["formatted_address"];
  }
}
