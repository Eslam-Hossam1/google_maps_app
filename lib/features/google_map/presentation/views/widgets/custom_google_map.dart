import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition cameraPosition;
  late GoogleMapController googleMapController;
  String? nightMapStyle;
  late Location location;
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
    loadGoogleMapStyle();
    location = Location();
    checkAndRequestLocationService();
  }

  Future<void> loadGoogleMapStyle() async {
    nightMapStyle = await rootBundle
        .loadString('assets/google_maps_styles/night_map_style.json');
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      style: nightMapStyle,
      initialCameraPosition: cameraPosition,
    );
  }

  void checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        // show error bar
      }
    }
    checkAndRequestLocationPermission();
  }

  bool isPermissionGranted(PermissionStatus permissionStatus) =>
      permissionStatus == PermissionStatus.granted;

  void checkAndRequestLocationPermission() async {
    var isPermissionEnabled =
        isPermissionGranted(await location.hasPermission());

    if (!isPermissionEnabled) {
      isPermissionEnabled =
          isPermissionGranted(await location.requestPermission());
      if (!isPermissionEnabled) {
        // show error bar
      }
    }
  }
}

// inquire about location service 
// rquestlocation permission
// getlocation
// display