import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition cameraPosition;
  late GoogleMapController googleMapController;
  String? nightMapStyle;
  Set<Marker> markers = {};
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
    initMarkers();
    loadGoogleMapStyle();
  }

  Future<void> loadGoogleMapStyle() async {
    nightMapStyle = await rootBundle
        .loadString('assets/google_maps_styles/night_map_style.json');
    setState(() {});
  }

  initMarkers() {
    Marker marker =
        Marker(markerId: MarkerId('1'), position: LatLng(31.053715, 31.407414));
    markers.add(marker);
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      style: nightMapStyle,
      initialCameraPosition: cameraPosition,
    );
  }
}
