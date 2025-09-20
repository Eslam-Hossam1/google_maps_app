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
  bool isFirstLocationCall = true;
  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
      target: LatLng(31.04093837052159, 31.379579171401787),
      zoom: 1,
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
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      style: nightMapStyle,
      initialCameraPosition: cameraPosition,
      onMapCreated: (controller) {
        googleMapController = controller;
        locationService.listenToLiveLocationChanges(onLocationChanged);
      },
    );
  }

  void onLocationChanged(LocationData locationData) {
    LatLng newLatLng = LatLng(
      locationData.latitude!,
      locationData.longitude!,
    );
    setNewLocationMarker(newLatLng);
    animateCameraToNewLocation(newLatLng);
  }

  void animateCameraToNewLocation(LatLng newLatLng) {
    if (isFirstLocationCall) {
      isFirstLocationCall = false;
      CameraPosition newCameraPostion =
          CameraPosition(target: newLatLng, zoom: 15);
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          newCameraPostion,
        ),
      );
    } else {
      googleMapController?.animateCamera(
        CameraUpdate.newLatLng(
          newLatLng,
        ),
      );
    }
  }

  void setNewLocationMarker(LatLng newLatLng) {
    markers = {
      Marker(
        markerId: const MarkerId('new_postion_marker'),
        position: newLatLng,
      ),
    };
    setState(() {});
  }
}

// inquire about location service 
// rquestlocation permission
// getlocation
// display