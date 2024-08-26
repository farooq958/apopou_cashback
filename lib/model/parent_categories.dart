 
import 'package:meta/meta.dart';
import 'dart:convert';

class ParentCategories {
  ParentCategories({
    required this.data,
    required this.meta,
  });

  final List<Datum> data;
  final Meta meta;

  factory ParentCategories.fromRawJson(String str) => ParentCategories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ParentCategories.fromJson(Map<String, dynamic> json) => ParentCategories(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class Datum {
  Datum({
    required this.identifier,
    required this.parentId,
    required this.categoryTitle,
    required this.img,
    required this.ico,
    required this.uri,
    required this.sortNo,
  });

  final int identifier;
  final String parentId;
  final String categoryTitle;
  final String img;
  final String ico;
  final String uri;
  final String sortNo;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    identifier: json["identifier"],
    parentId: json["parentID"],
    categoryTitle: json["categoryTitle"],
    img: json["IMG"],
    ico: json["ICO"],
    uri: json["URI"],
    sortNo: json["sortNo"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "parentID": parentId,
    "categoryTitle": categoryTitle,
    "IMG": img,
    "ICO": ico,
    "URI": uri,
    "sortNo": sortNo,
  };
}

class Meta {
  Meta({
    required this.pagination,
  });

  final Pagination pagination;

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  Pagination({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.links,
  });

  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;
  final Links links;

  factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    count: json["count"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    totalPages: json["total_pages"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "total_pages": totalPages,
    "links": links.toJson(),
  };
}

class Links {
  Links();

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
  );

  Map<String, dynamic> toJson() => {
  };
}
