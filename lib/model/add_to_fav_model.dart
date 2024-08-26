// To parse this JSON data, do
//
//     final addToFav = addToFavFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AddToFav {
  AddToFav({
    required this.message,
    required this.success,
  });

  String message;
  bool success;

  factory AddToFav.fromJson(String str) => AddToFav.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddToFav.fromMap(Map<String, dynamic> json) => AddToFav(
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "success": success,
  };
}
