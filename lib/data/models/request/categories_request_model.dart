import 'package:meta/meta.dart';
import 'dart:convert';

class CategoriesRequestModel {
  final int id;
  final String name;
  final String image;
  final DateTime creationAt;
  final DateTime updatedAt;

  CategoriesRequestModel({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory CategoriesRequestModel.fromJson(String str) =>
      CategoriesRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesRequestModel.fromMap(Map<String, dynamic> json) =>
      CategoriesRequestModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "creationAt": creationAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
