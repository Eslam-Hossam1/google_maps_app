import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

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
  Set<Circle> circles = {};

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
    initCircles();
    loadGoogleMapStyle();
  }

  void initCircles() {
    Circle pizzaMaxServingCircle = Circle(
        strokeWidth: 3,
        fillColor: Colors.pink.withAlpha(50),
        strokeColor: Colors.cyan,
        circleId: CircleId('1'),
        center: LatLng(31.054193594779825, 31.40331839496111),
        radius: 800);
    circles.add(pizzaMaxServingCircle);
  }

  Future<void> loadGoogleMapStyle() async {
    nightMapStyle = await rootBundle
        .loadString('assets/google_maps_styles/night_map_style.json');
    setState(() {});
  }

  
  initMarkers() async {
    BitmapDescriptor icon = await BitmapDescriptor.asset(
      ImageConfiguration(),
      'assets/images/flag.png',
    );
    Marker pizzaMaxMarker = Marker(
      icon: icon,
      markerId: MarkerId('1'),
      position: LatLng(31.054193594779825, 31.40331839496111),
    );

    markers.add(pizzaMaxMarker);
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
      markers: markers,
      circles: circles,
      style: nightMapStyle,
      initialCameraPosition: cameraPosition,
    );
  }
}
