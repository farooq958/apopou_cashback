import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';

class ParentCategory extends Equatable {
  final int identifier;
  final String parentID;
  final String categoryTitle;
  final String IMG;
  final String ICO;
  final String URI;
  final String sortNo;
  //final String sucategories;
  final List<Category> sucategories;
  ParentCategory({
    required this.identifier,
    required this.parentID,
    required this.categoryTitle,
    required this.IMG,
    required this.ICO,
    required this.URI,
    required this.sortNo,
    required this.sucategories,
  });

  ParentCategory copyWith({
    int? identifier,
    String? parentID,
    String? categoryTitle,
    String? IMG,
    String? ICO,
    String? URI,
    String? sortNo,
    //String? sucategories,
    List<Category>? sucategories,
  }) {
    return ParentCategory(
      identifier: identifier ?? this.identifier,
      parentID: parentID ?? this.parentID,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      IMG: IMG ?? this.IMG,
      ICO: ICO ?? this.ICO,
      URI: URI ?? this.URI,
      sortNo: sortNo ?? this.sortNo,
      //sucategories: sucategories ?? this.sucategories,
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
      //'sucategories': sucategories,
      'sucategories': sucategories.map((x) => x.toMap()).toList(),
    };
  }

  factory ParentCategory.fromMap(Map<String, dynamic> map) {
    return ParentCategory(
      identifier: map['identifier']?.toInt() ?? 0,
      parentID: map['parentID'] ?? '',
      categoryTitle: map['categoryTitle'] ?? '',
      IMG: map['IMG'] ?? '',
      ICO: map['ICO'] ?? '',
      URI: map['URI'] ?? '',
      sortNo: map['sortNo'] ?? '',
      //sucategories: map["sucategories"] ?? '',
      sucategories: List<Category>.from(
          map['sucategories']?.map((x) => Category.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ParentCategory.fromJson(String source) =>
      ParentCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParentCategory(identifier: $identifier, parentID: $parentID, categoryTitle: $categoryTitle, IMG: $IMG, ICO: $ICO, URI: $URI, sortNo: $sortNo, sucategories: $sucategories)';
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

class Category extends Equatable {
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
  Category({
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

  Category copyWith({
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
    return Category(
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

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
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

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(category_id: $category_id, parent_id: $parent_id, name: $name, icon: $icon, img: $img, description: $description, category_url: $category_url, meta_description: $meta_description, meta_keywords: $meta_keywords, sort_order: $sort_order, featured: $featured)';
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
