import 'highlight.dart';

class Text {
  String? primary;
  String? secondary;
  List<Highlight>? highlight;

  Text({this.primary, this.secondary, this.highlight});

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        primary: json['primary'] as String?,
        secondary: json['secondary'] as String?,
        highlight: (json['highlight'] as List<dynamic>?)
            ?.map((e) => Highlight.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'primary': primary,
        'secondary': secondary,
        'highlight': highlight?.map((e) => e.toJson()).toList(),
      };
}
