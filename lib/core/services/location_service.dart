import 'package:location/location.dart';

class LocationService {
  Location location = Location();

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

  void listenToLocationChanges(
    void Function(LocationData)? onData,
  ) {
    location.onLocationChanged.listen(onData);
  }
}
