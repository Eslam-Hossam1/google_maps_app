import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition cameraPosition;
  late CameraTargetBounds cameraTargetBounds;
  late GoogleMapController googleMapController;
  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
      target: LatLng(
        31.04093837052159,
        31.379407510024834,
      ),
      zoom: 14,
    );
    cameraTargetBounds = CameraTargetBounds(
      LatLngBounds(
        southwest: LatLng(31.022698789691688, 31.321557625992035),
        northeast: LatLng(31.071525950194122, 31.43296585963383),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.satellite,
      initialCameraPosition: cameraPosition,
    );
  }
}
