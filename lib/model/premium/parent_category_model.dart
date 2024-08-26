import 'dart:convert';

class PremiumParentCategoryModel {
  List<ParentCategoryDataModel>? data;
  ParentCategoryMetaModel? meta;

  PremiumParentCategoryModel({
    this.data,
    this.meta,
  });

  PremiumParentCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ParentCategoryDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ParentCategoryDataModel.fromJson(v));
      });
    }
    meta = json['meta'] != null
        ? new ParentCategoryMetaModel.fromJson(json['meta'])
        : null;
  }
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class ParentCategoryDataModel {
  int? identifier;
  String? parentID;
  String? name;
  String? imgPath;
  int? mobileAppEnabled;
  int? order;

  ParentCategoryDataModel({
    this.identifier,
    this.parentID,
    this.name,
    this.imgPath,
    this.mobileAppEnabled,
    this.order,
  });

  ParentCategoryDataModel.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    parentID = json['parentID'];
    name = json['name'];
    imgPath = json['img_path'];
    mobileAppEnabled = json['mobileAppEnabled'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['parentID'] = this.parentID;
    data['name'] = this.name;
    data['img_path'] = this.imgPath;
    data['mobileAppEnabled'] = this.mobileAppEnabled;
    data['order'] = this.order;
    return data;
  }
}

class ParentCategoryMetaModel {
  ParentCategoryPaginationModel? pagination;

  ParentCategoryMetaModel({
    this.pagination,
  });

  ParentCategoryMetaModel.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new ParentCategoryPaginationModel.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class ParentCategoryPaginationModel {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  ParentCategoryPaginationModel({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  ParentCategoryPaginationModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    return data;
  }
}
