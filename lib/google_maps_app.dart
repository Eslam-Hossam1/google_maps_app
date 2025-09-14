import 'package:flutter/material.dart';
import 'package:google_maps_app/features/google_map/google_map_view.dart';

class GoogleMapsApp extends StatelessWidget {
  const GoogleMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapView(),
    );
  }
}
