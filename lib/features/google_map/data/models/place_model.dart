import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final String id;
  final LatLng position;
  final String name;

  PlaceModel({required this.id, required this.position, required this.name});
}

List<PlaceModel> places = [
  PlaceModel(
    id: '1',
    position: LatLng(31.053715, 31.407414),
    name: 'My Home',
  ),
  PlaceModel(
    id: '2',
    position: LatLng(31.047308192567723, 31.36892184168384),
    name: 'نادي الجزيرة',
  ),
  PlaceModel(
    id: '3',
    position: LatLng(31.04670991615564, 31.38001270710928),
    name: 'شارع بورسعيد',
  ),
];
