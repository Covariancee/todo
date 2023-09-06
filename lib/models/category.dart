import 'dart:convert';

class Category {
  final int id;
  final String title;
  final String color;
  final String icon;

  Category({
    required this.id,
    required this.title,
    required this.color,
    required this.icon,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        color: json["color"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "color": color,
        "icon": icon,
      };
}
