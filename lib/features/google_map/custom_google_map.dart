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
    return Stack(
      children: [
        GoogleMap(
          //  cameraTargetBounds: cameraTargetBounds,
          onMapCreated: (controller) => googleMapController = controller,
          initialCameraPosition: cameraPosition,
        ),
        Positioned(
          bottom: 36,
          left: 50,
          right: 50,
          child: ElevatedButton(
            onPressed: () {
                googleMapController.animateCamera(
                  CameraUpdate.newLatLng(
                      LatLng(30.05711214641764, 31.303165496389212)),
               );
            },
            child: Text('change postion'),
          ),
        ),
      ],
    );
  }
}
