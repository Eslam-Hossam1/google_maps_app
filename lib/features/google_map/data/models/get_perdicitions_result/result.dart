import 'place.dart';
import 'text.dart';

class Result {
  String? type;
  Text? text;
  String? link;
  Place? place;

  Result({this.type, this.text, this.link, this.place});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        type: json['type'] as String?,
        text: json['text'] == null
            ? null
            : Text.fromJson(json['text'] as Map<String, dynamic>),
        link: json['link'] as String?,
        place: json['place'] == null
            ? null
            : Place.fromJson(json['place'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'text': text?.toJson(),
        'link': link,
        'place': place?.toJson(),
      };
}
