import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';

class SubCategoryModel extends Equatable {
  final int identifier;
  final String storeName;
  final String storeImgURL;
  final String storeCashback;
  final int featuredStore;
  final int noOfVisits;
  final int favoriters;
  final int coupons_count;
  final int products_count;
  final List<ParentSubCategory> sucategories;
  SubCategoryModel({
    required this.identifier,
    required this.storeName,
    required this.storeImgURL,
    required this.storeCashback,
    required this.featuredStore,
    required this.noOfVisits,
    required this.favoriters,
    required this.coupons_count,
    required this.products_count,
    required this.sucategories,
  });

  SubCategoryModel copyWith({
    int? identifier,
    String? storeName,
    String? storeImgURL,
    String? storeCashback,
    int? featuredStore,
    int? noOfVisits,
    int? favoriters,
    int? coupons_count,
    int? products_count,
    List<ParentSubCategory>? sucategories,
  }) {
    return SubCategoryModel(
      identifier: identifier ?? this.identifier,
      storeName: storeName ?? this.storeName,
      storeImgURL: storeImgURL ?? this.storeImgURL,
      storeCashback: storeCashback ?? this.storeCashback,
      featuredStore: featuredStore ?? this.featuredStore,
      noOfVisits: noOfVisits ?? this.noOfVisits,
      favoriters: favoriters ?? this.favoriters,
      coupons_count: coupons_count ?? this.coupons_count,
      products_count: products_count ?? this.products_count,
      sucategories: sucategories ?? this.sucategories,
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
      'sucategories': sucategories.map((x) => x.toMap()).toList(),
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      identifier: map['identifier']?.toInt() ?? 0,
      storeName: map['storeName'] ?? '',
      storeImgURL: map['storeImgURL'] ?? '',
      storeCashback: map['storeCashback'] ?? '',
      featuredStore: map['featuredStore']?.toInt() ?? 0,
      noOfVisits: map['noOfVisits']?.toInt() ?? 0,
      favoriters: map['favoriters']?.toInt() ?? 0,
      coupons_count: map['coupons_count']?.toInt() ?? 0,
      products_count: map['products_count']?.toInt() ?? 0,
      sucategories: List<ParentSubCategory>.from(
          map['sucategories']?.map((x) => ParentSubCategory.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategoryModel.fromJson(String source) =>
      SubCategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubCategoryModel(identifier: $identifier, storeName: $storeName, storeImgURL: $storeImgURL, storeCashback: $storeCashback, featuredStore: $featuredStore, noOfVisits: $noOfVisits, favoriters: $favoriters, coupons_count: $coupons_count, products_count: $products_count, sucategories: $sucategories)';
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
      sucategories,
    ];
  }
}

class ParentSubCategory extends Equatable {
  final int category_id;
  final int parent_id;
  final String name;
  final String icon;
  final String img;
  final String description;
  final String category_url;
  final String meta_description;
  final String meta_keywords;
  final int sort_order;
  final int featured;
  ParentSubCategory({
    required this.category_id,
    required this.parent_id,
    required this.name,
    required this.icon,
    required this.img,
    required this.description,
    required this.category_url,
    required this.meta_description,
    required this.meta_keywords,
    required this.sort_order,
    required this.featured,
  });

  ParentSubCategory copyWith({
    int? category_id,
    int? parent_id,
    String? name,
    String? icon,
    String? img,
    String? description,
    String? category_url,
    String? meta_description,
    String? meta_keywords,
    int? sort_order,
    int? featured,
  }) {
    return ParentSubCategory(
      category_id: category_id ?? this.category_id,
      parent_id: parent_id ?? this.parent_id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      img: img ?? this.img,
      description: description ?? this.description,
      category_url: category_url ?? this.category_url,
      meta_description: meta_description ?? this.meta_description,
      meta_keywords: meta_keywords ?? this.meta_keywords,
      sort_order: sort_order ?? this.sort_order,
      featured: featured ?? this.featured,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': category_id,
      'parent_id': parent_id,
      'name': name,
      'icon': icon,
      'img': img,
      'description': description,
      'category_url': category_url,
      'meta_description': meta_description,
      'meta_keywords': meta_keywords,
      'sort_order': sort_order,
      'featured': featured,
    };
  }

  factory ParentSubCategory.fromMap(Map<String, dynamic> map) {
    return ParentSubCategory(
      category_id: map['category_id']?.toInt() ?? 0,
      parent_id: map['parent_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
      img: map['img'] ?? '',
      description: map['description'] ?? '',
      category_url: map['category_url'] ?? '',
      meta_description: map['meta_description'] ?? '',
      meta_keywords: map['meta_keywords'] ?? '',
      sort_order: map['sort_order']?.toInt() ?? 0,
      featured: map['featured']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParentSubCategory.fromJson(String source) =>
      ParentSubCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParentSubCategory(category_id: $category_id, parent_id: $parent_id, name: $name, icon: $icon, img: $img, description: $description, category_url: $category_url, meta_description: $meta_description, meta_keywords: $meta_keywords, sort_order: $sort_order, featured: $featured)';
  }

  @override
  List<Object> get props {
    return [
      category_id,
      parent_id,
      name,
      icon,
      img,
      description,
      category_url,
      meta_description,
      meta_keywords,
      sort_order,
      featured,
    ];
  }
}
