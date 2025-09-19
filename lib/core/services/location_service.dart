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

  Future<bool> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
    }
    return isServiceEnabled;
  }

  bool isPermissionGranted(PermissionStatus permissionStatus) =>
      permissionStatus == PermissionStatus.granted;

  Future<bool> checkAndRequestLocationPermission() async {
    var isPermissionEnabled =
        isPermissionGranted(await location.hasPermission());

    if (!isPermissionEnabled) {
      isPermissionEnabled =
          isPermissionGranted(await location.requestPermission());
    }
    return isPermissionEnabled;
  }

  void listenToLiveLocationChanges(
    void Function(LocationData)? onData,
  ) {
    _locationSubscription?.cancel();
    _locationSubscription = location.onLocationChanged.listen(onData);
  }

  void dispose() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }
}
