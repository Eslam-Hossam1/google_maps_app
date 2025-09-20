import 'dart:async';

import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  static LocationService? _locationService;
  LocationService._();
  factory LocationService() {
    return _locationService ??= LocationService._();
  }
  StreamSubscription<LocationData>? _locationSubscription;

  Future<void> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
    }
    if (!isServiceEnabled) {
      throw LocationServiceException();
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }
    if (permissionStatus != PermissionStatus.granted) {
      permissionStatus = await location.requestPermission();
    }
    if (permissionStatus != PermissionStatus.granted) {
      throw LocationPermissionException();
    }
  }

  void listenToLiveLocationChanges(
    void Function(LocationData)? onData,
  ) async {
    _locationSubscription?.cancel();
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    _locationSubscription = location.onLocationChanged.listen(onData);
  }

  void dispose() {
    _locationSubscription?.cancel();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
