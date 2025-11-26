class Location {
  String? address;
  String? locality;
  String? region;
  String? postcode;
  String? country;
  String? formattedAddress;

  Location({
    this.address,
    this.locality,
    this.region,
    this.postcode,
    this.country,
    this.formattedAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json['address'] as String?,
        locality: json['locality'] as String?,
        region: json['region'] as String?,
        postcode: json['postcode'] as String?,
        country: json['country'] as String?,
        formattedAddress: json['formatted_address'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'locality': locality,
        'region': region,
        'postcode': postcode,
        'country': country,
        'formatted_address': formattedAddress,
      };
}
