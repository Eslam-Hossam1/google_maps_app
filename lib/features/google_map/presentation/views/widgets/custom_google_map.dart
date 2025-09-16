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
  Set<Polygon> polygons = {};
  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
      target: LatLng(
        31.04093837052159,
        31.379407510024834,
      ),
      zoom: 0,
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
    //to be added to egypt Polygon as hole
    List<LatLng> sharqiaLatLngs = [
      LatLng(30.8500, 31.6000), // شمال غربي قريب من القليوبية
      LatLng(30.9500, 31.8500), // شمال عند الدقهلية
      LatLng(31.1500, 31.9000), // شمال شرقي ناحية المنزلة
      LatLng(30.9000, 32.0000), // شرق قريب من الإسماعيلية
      LatLng(30.6000, 32.0500), // جنوب شرق قريب من السويس
      LatLng(30.3000, 31.9000), // جنوب قريب من القاهرة
      LatLng(30.4000, 31.6000), // جنوب غربي
      LatLng(30.7000, 31.5000), // غرب (بلبيس – العاشر من رمضان)
    ];

    //polygon is any 2-d shape
    Polygon egyptPolygon = Polygon(
        polygonId: PolygonId('1'),
        points: [
          LatLng(31.59873996440776, 25.091298804499562),
          LatLng(31.56165580486618, 30.924414292410454),
          LatLng(31.264452333541957, 34.22404230723502),
          LatLng(29.54090335472602, 34.886879763893035),
          LatLng(28.104223304617385, 34.550115425233166),
          LatLng(22.2916725000781, 37.68348796754582),
          LatLng(22.006883023279123, 38.1081038728126),
          LatLng(22.006883023279123, 25.003578520613683),
        ],
        fillColor: Colors.pink.withAlpha(50),
        strokeColor: Colors.cyan,
        strokeWidth: 5,
        holes: [
          sharqiaLatLngs,
        ]);
    polygons.add(egyptPolygon);
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
      polygons: polygons,
      markers: markers,
      style: nightMapStyle,
      initialCameraPosition: cameraPosition,
    );
  }
}
