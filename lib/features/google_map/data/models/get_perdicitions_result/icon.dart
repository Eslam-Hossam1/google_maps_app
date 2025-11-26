class Icon {
  String? prefix;
  String? suffix;

  Icon({this.prefix, this.suffix});

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        prefix: json['prefix'] as String?,
        suffix: json['suffix'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'prefix': prefix,
        'suffix': suffix,
      };
}
