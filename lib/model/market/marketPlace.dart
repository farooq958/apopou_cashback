import 'dart:convert';
import 'dart:developer';

import 'package:cashback/model/servicesModel/parentCategory.dart';
import 'package:equatable/equatable.dart';

class MarketPlaceModel extends Equatable {
  final int identifier;
  final String storeName;
  final String storeImgURL;
  final String storeCashback;
  final int featuredStore;
  final int noOfVisits;
  int favoriters;
  final int coupons_count;
  final int products_count;
  final List<PCategory> categories;
  MarketPlaceModel({
    required this.identifier,
    required this.storeName,
    required this.storeImgURL,
    required this.storeCashback,
    required this.featuredStore,
    required this.noOfVisits,
    required this.favoriters,
    required this.coupons_count,
    required this.products_count,
    required this.categories,
  });

  MarketPlaceModel copyWith({
    int? identifier,
    String? storeName,
    String? storeImgURL,
    String? storeCashback,
    int? featuredStore,
    int? noOfVisits,
    int? favoriters,
    int? coupons_count,
    int? products_count,
    List<PCategory>? categories,
  }) {
    return MarketPlaceModel(
      identifier: identifier ?? this.identifier,
      storeName: storeName ?? this.storeName,
      storeImgURL: storeImgURL ?? this.storeImgURL,
      storeCashback: storeCashback ?? this.storeCashback,
      featuredStore: featuredStore ?? this.featuredStore,
      noOfVisits: noOfVisits ?? this.noOfVisits,
      favoriters: favoriters ?? this.favoriters,
      coupons_count: coupons_count ?? this.coupons_count,
      products_count: products_count ?? this.products_count,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'identifier': identifier,
      'storeName': storeName,
      'storeImgURL': storeImgURL,
      'storeCashback': storeCashback,
      'featuredStore': featuredStore,
      'noOfVisits': noOfVisits,
      'favoriters': favoriters,
      'coupons_count': coupons_count,
      'products_count': products_count,
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory MarketPlaceModel.fromMap(Map<String, dynamic> map) {
    return MarketPlaceModel(
      identifier: map['identifier']?.toInt() ?? 0,
      storeName: map['storeName'] ?? '',
      storeImgURL: map['storeImgURL'] ?? '',
      storeCashback: map['storeCashback'] ?? '',
      featuredStore: map['featuredStore']?.toInt() ?? 0,
      noOfVisits: map['noOfVisits']?.toInt() ?? 0,
      favoriters: map['favoriters']?.toInt() ?? 0,
      coupons_count: map['coupons_count']?.toInt() ?? 0,
      products_count: map['products_count']?.toInt() ?? 0,
      categories: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory MarketPlaceModel.fromJson(String source) =>
      MarketPlaceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MarketPlaceModel(identifier: $identifier, storeName: $storeName, storeImgURL: $storeImgURL, storeCashback: $storeCashback, featuredStore: $featuredStore, noOfVisits: $noOfVisits, favoriters: $favoriters, coupons_count: $coupons_count, products_count: $products_count, categories: $categories)';
  }

  @override
  List<Object> get props {
    return [
      identifier,
      storeName,
      storeImgURL,
      storeCashback,
      featuredStore,
      noOfVisits,
      favoriters,
      coupons_count,
      products_count,
      categories,
    ];
  }
}

class PCategory extends Equatable {
  final int identifier;
  final String parentID;
  final String categoryTitle;
  final String IMG;
  final String ICO;
  final String URI;
  final String sortNo;
  final List<Category> sucategories;
  PCategory({
    required this.identifier,
    required this.parentID,
    required this.categoryTitle,
    required this.IMG,
    required this.ICO,
    required this.URI,
    required this.sortNo,
    required this.sucategories,
  });

  PCategory copyWith({
    int? identifier,
    String? parentID,
    String? categoryTitle,
    String? IMG,
    String? ICO,
    String? URI,
    String? sortNo,
    List<Category>? sucategories,
  }) {
    return PCategory(
      identifier: identifier ?? this.identifier,
      parentID: parentID ?? this.parentID,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      IMG: IMG ?? this.IMG,
      ICO: ICO ?? this.ICO,
      URI: URI ?? this.URI,
      sortNo: sortNo ?? this.sortNo,
      sucategories: sucategories ?? this.sucategories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'identifier': identifier,
      'parentID': parentID,
      'categoryTitle': categoryTitle,
      'IMG': IMG,
      'ICO': ICO,
      'URI': URI,
      'sortNo': sortNo,
      'sucategories': sucategories.map((x) => x.toMap()).toList(),
    };
  }

  factory PCategory.fromMap(Map<String, dynamic> map) {
    return PCategory(
      identifier: map['identifier']?.toInt() ?? 0,
      parentID: map['parentID'] ?? '',
      categoryTitle: map['categoryTitle'] ?? '',
      IMG: map['IMG'] ?? '',
      ICO: map['ICO'] ?? '',
      URI: map['URI'] ?? '',
      sortNo: map['sortNo'] ?? '',
      sucategories: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PCategory.fromJson(String source) =>
      PCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PCategory(identifier: $identifier, parentID: $parentID, categoryTitle: $categoryTitle, IMG: $IMG, ICO: $ICO, URI: $URI, sortNo: $sortNo, sucategories: $sucategories)';
  }

  @override
  List<Object> get props {
    return [
      identifier,
      parentID,
      categoryTitle,
      IMG,
      ICO,
      URI,
      sortNo,
      sucategories,
    ];
  }
}
