import 'category.dart';
import 'location.dart';

class Place {
  String? fsqPlaceId;
  double? latitude;
  double? longitude;
  List<Category>? categories;
  int? distance;
  Location? location;
  String? name;

  Place({
    this.fsqPlaceId,
    this.latitude,
    this.longitude,
    this.categories,
    this.distance,
    this.location,
    this.name,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        fsqPlaceId: json['fsq_place_id'] as String?,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
        distance: json['distance'] as int?,
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'fsq_place_id': fsqPlaceId,
        'latitude': latitude,
        'longitude': longitude,
        'categories': categories?.map((e) => e.toJson()).toList(),
        'distance': distance,
        'location': location?.toJson(),
        'name': name,
      };
}
