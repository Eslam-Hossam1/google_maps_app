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

  Future<Uint8List> modifyImageWidth(String image, int width) async {
    var imageBytes = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
      imageBytes.buffer.asUint8List(),
      targetWidth: width,
    );
    var imageFrame = await imageCodec.getNextFrame();
    var modifiedImageBytes = await imageFrame.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    var modifiedImage = modifiedImageBytes!.buffer.asUint8List();
    return modifiedImage;
  }

  initMarkers() async {
    final modifiedImage = await modifyImageWidth(
      'assets/images/flag.png',
      50,
    );
    BitmapDescriptor icon = BitmapDescriptor.bytes(modifiedImage);
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
      markers: markers,
      style: nightMapStyle,
      initialCameraPosition: cameraPosition,
    );
  }
}
