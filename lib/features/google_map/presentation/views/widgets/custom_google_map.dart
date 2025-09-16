import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_app/features/google_map/data/models/place_model.dart';
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
  Set<Polyline> polylines = {};
  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
      target: LatLng(
        31.04093837052159,
        31.379407510024834,
      ),
      zoom: 10,
    );
    initMarkers();
    initPolyLines();
    loadGoogleMapStyle();
  }

  Future<void> loadGoogleMapStyle() async {
    nightMapStyle = await rootBundle
        .loadString('assets/google_maps_styles/night_map_style.json');
    setState(() {});
  }

  initPolyLines() {
    Polyline polyline = Polyline(
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      color: Colors.red,
      width: 10,
      polylineId: PolylineId('1'),
      points: [
        LatLng(30.97674028818873, 31.174625298689165),
        LatLng(31.047972600676886, 31.385088299514486),
        LatLng(31.211262358602678, 29.94341404324599),
      ],
    );
    polylines.add(polyline);
  }

  initMarkers() async {
    BitmapDescriptor icon = await BitmapDescriptor.asset(
      ImageConfiguration(),
      'assets/images/flag.png',
    );
    Set<Marker> newMarkers = places.map((place) {
      return Marker(
        icon: icon,
        markerId: MarkerId(place.id),
        position: place.position,
        infoWindow: InfoWindow(
          title: place.name,
        ),
      );
    }).toSet();

    markers.addAll(newMarkers);
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
      polylines: polylines,
      markers: markers,
      style: nightMapStyle,
      initialCameraPosition: cameraPosition,
    );
  }
}
