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
  GoogleMapController? googleMapController;
  String? nightMapStyle;
  late Location location;
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
      target: LatLng(
        35.04093837052159,
        35.379407510024834,
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
    googleMapController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      style: nightMapStyle,
      initialCameraPosition: cameraPosition,
      onMapCreated: (controller) {
        googleMapController = controller;
        checkPermissionThenListenToLocation();
      },
    );
  }

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        // show error bar
      }
    }
  }

  bool isPermissionGranted(PermissionStatus permissionStatus) =>
      permissionStatus == PermissionStatus.granted;

  Future<bool> checkAndRequestLocationPermission() async {
    var isPermissionEnabled =
        isPermissionGranted(await location.hasPermission());

    if (!isPermissionEnabled) {
      isPermissionEnabled =
          isPermissionGranted(await location.requestPermission());
      if (!isPermissionEnabled) {
        return false;
      }
    }
    return true;
  }

  void checkPermissionThenListenToLocation() async {
    await checkAndRequestLocationService();
    bool hasPermission = await checkAndRequestLocationPermission();
    if (hasPermission) {
      listenToLocation();
    } else {}
  }

  void listenToLocation() {
    location.changeSettings(distanceFilter: 2);
    location.onLocationChanged.listen((LocationData locationData) {
      LatLng newLatLng = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      Marker newPostionMarker = Marker(
        markerId: MarkerId(
          'new_postion_marker',
        ),
        position: newLatLng,
      );
      markers.add(newPostionMarker);
      setState(() {});
      googleMapController?.animateCamera(
        CameraUpdate.newLatLng(
          newLatLng,
        ),
      );
    });
  }
}

// inquire about location service 
// rquestlocation permission
// getlocation
// display