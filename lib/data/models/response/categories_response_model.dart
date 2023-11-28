import 'package:meta/meta.dart';
import 'dart:convert';

class CategoriesResponseModel {
  final int id;
  final String name;
  final String image;
  final DateTime creationAt;
  final DateTime updatedAt;

  CategoriesResponseModel({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory CategoriesResponseModel.fromJson(String str) =>
      CategoriesResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesResponseModel.fromMap(Map<String, dynamic> json) =>
      CategoriesResponseModel(
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
