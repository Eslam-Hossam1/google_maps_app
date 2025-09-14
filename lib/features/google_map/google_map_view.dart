
import 'package:flutter/material.dart';
import 'package:google_maps_app/features/google_map/custom_google_map.dart';

class GoogleMapsView extends StatelessWidget {
  const GoogleMapsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGoogleMap(),
    );
  }
}
