import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_app/core/services/location_service.dart';
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
  late LocationService locationService;
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
      target: LatLng(0, 0),
    );
    loadGoogleMapStyle();
    locationService = LocationService();
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
    locationService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      style: nightMapStyle,
      initialCameraPosition: cameraPosition,
      onMapCreated: (controller) {
        googleMapController = controller;
        getLocationAndAnimateCamera();
      },
    );
  }

  getLocationAndAnimateCamera() async {
    LocationData locationData = await locationService.getLocationData();
    LatLng newLatLng = LatLng(
      locationData.latitude!,
      locationData.longitude!,
    );
    setLocationMarker(newLatLng);
    animateCameraToLocation(newLatLng);
  }

  void animateCameraToLocation(LatLng newLatLng) {
    CameraPosition newCameraPostion =
        CameraPosition(target: newLatLng, zoom: 16);
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        newCameraPostion,
      ),
    );
  }

  void setLocationMarker(LatLng newLatLng) {
    markers.add(
      Marker(
        markerId: const MarkerId('new_postion_marker'),
        position: newLatLng,
      ),
    );
    setState(() {});
  }
}

  

// inquire about location service 
// rquestlocation permission
// getlocation
// display