// To parse this JSON data, do
//
//     final marketPlaceModel = marketPlaceModelFromJson(jsonString);

// MarketPlaceModel marketPlaceModelFromJson(String str) =>
//     MarketPlaceModel.fromJson(json.decode(str));
//
// String marketPlaceModelToJson(MarketPlaceModel data) =>
//     json.encode(data.toJson());

import 'dart:developer';

class MarketPlaceModel {
  MarketPlaceModel({
    required this.data,
    required this.meta,
  });

  List<MarketPlaceModelDatum> data;
  Meta meta;

  factory MarketPlaceModel.fromJson(Map<String, dynamic> json) =>
      MarketPlaceModel(
        data: List<MarketPlaceModelDatum>.from(
            json["data"].map((x) => MarketPlaceModelDatum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class MarketPlaceModelDatum {
  MarketPlaceModelDatum({
    required this.identifier,
    required this.storeName,
    required this.storeImgUrl,
    required this.storeCashback,
    required this.featuredStore,
    required this.noOfVisits,
    required this.favoriters,
    required this.couponsCount,
    required this.productsCount,
    required this.categories,
  });

  int identifier;
  String storeName;
  String storeImgUrl;
  String storeCashback;
  int featuredStore;
  int noOfVisits;
  int favoriters;
  int couponsCount;
  int productsCount;
  Categories categories;

  factory MarketPlaceModelDatum.fromJson(Map<String, dynamic> json) {
    return MarketPlaceModelDatum(
      identifier: json["identifier"] ?? 0,
      storeName: json["storeName"] ?? "",
      storeImgUrl: json["storeImgURL"] ?? "",
      storeCashback: json["storeCashback"] ?? "",
      featuredStore: json["featuredStore"] ?? 0,
      noOfVisits: json["noOfVisits"] ?? 0,
      favoriters: json["favoriters"] ?? 0,
      couponsCount: json["coupons_count"] ?? 0,
      productsCount: json["products_count"] ?? 0,
      categories: Categories.fromJson(json["categories"]["data"]),
      // categoriesJson[categoriesName]["Items"]
    );
  }

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "storeName": storeName,
        "storeImgURL": storeImgUrl,
        "storeCashback": storeCashback,
        "featuredStore": featuredStore,
        "noOfVisits": noOfVisits,
        "favoriters": favoriters,
        "coupons_count": couponsCount,
        "products_count": productsCount,
        "categories": categories.toJson(),
      };
}

class Categories {
  Categories({
    required this.data,
  });

  List<CategoriesDatum>? data;

  factory Categories.fromJson(Map<String, dynamic> json) {
    log("json testing cat $json");

    log("this is texting.....................}");

    log("json testing cat ");

    return Categories(
      data: List<CategoriesDatum>.from(
          json["data"].forEach((e) => CategoriesDatum.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoriesDatum {
  CategoriesDatum({
    required this.identifier,
    required this.parentId,
    required this.categoryTitle,
    required this.img,
    required this.ico,
    required this.uri,
    required this.sortNo,
    required this.sucategories,
  });

  int identifier;
  String parentId;
  String categoryTitle;
  String img;
  String ico;
  String uri;
  String sortNo;
  String sucategories;

  factory CategoriesDatum.fromJson(Map<String, dynamic> json) {
    log("list of data ${json}");

    return CategoriesDatum(
      identifier: json["identifier"] ?? 0,
      parentId: "",
      categoryTitle: json["categoryTitle"] ?? "",
      img: json["IMG"] ?? "",
      ico: json["ICO"] ?? "",
      uri: json["URI"] ?? "",
      sortNo: json["sortNo"] ?? "",
      sucategories: json["sucategories"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "parentID": parentId,
        "categoryTitle": categoryTitle,
        "IMG": img,
        "ICO": ico,
        "URI": uri,
        "sortNo": sortNo,
        "sucategories": sucategories,
      };
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

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
  });

  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}
