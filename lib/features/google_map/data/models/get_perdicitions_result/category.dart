import 'icon.dart';

class Category {
  String? fsqCategoryId;
  String? name;
  String? shortName;
  String? pluralName;
  Icon? icon;

  Category({
    this.fsqCategoryId,
    this.name,
    this.shortName,
    this.pluralName,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        fsqCategoryId: json['fsq_category_id'] as String?,
        name: json['name'] as String?,
        shortName: json['short_name'] as String?,
        pluralName: json['plural_name'] as String?,
        icon: json['icon'] == null
            ? null
            : Icon.fromJson(json['icon'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'fsq_category_id': fsqCategoryId,
        'name': name,
        'short_name': shortName,
        'plural_name': pluralName,
        'icon': icon?.toJson(),
      };
}
