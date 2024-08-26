// To parse this JSON data, do
//
//     final removeFavModel = removeFavModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class RemoveFavModel {
  RemoveFavModel({
    required this.message,
    required this.success,
  });

  final String message;
  final bool success;

  factory RemoveFavModel.fromRawJson(String str) => RemoveFavModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RemoveFavModel.fromJson(Map<String, dynamic> json) => RemoveFavModel(
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
  };
}
