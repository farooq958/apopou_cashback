// class ClickHistoryModel {
//   final int identifier;
//   final int userId;
//   final String clickRef;
//   final int retailerId;
//   final String retailor;
//   final String clickIp;
//   final String dateAdded;
//   ClickHistoryModel({
//     required this.identifier,
//     required this.userId,
//     required this.clickRef,
//     required this.retailerId,
//     required this.retailor,
//     required this.clickIp,
//     required this.dateAdded,
//   });

//   factory ClickHistoryModel.fromMap(Map<String, dynamic> map) {
//     return ClickHistoryModel(
//       identifier: map['identifier'] as int,
//       userId: map['userID'] as int,
//       clickRef: map['clickRef'] as String,
//       retailerId: map['retailerID'] as int,
//       retailor: map['retailor'] as String,
//       clickIp: map['clickIp'] as String,
//       dateAdded: map['dateAdded'] as String,
//     );
//   }
// }

class ClickHistoryModel {
  List<ClickHistoryData>? data;
  ClickHistoryMeta? meta;

  ClickHistoryModel({this.data, this.meta});

  ClickHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ClickHistoryData>[];
      json['data'].forEach((v) {
        data!.add(ClickHistoryData.fromJson(v));
      });
    }
    meta = json['meta'] != null
        ? new ClickHistoryMeta.fromJson(json['meta'])
        : null;
  }

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

class ClickHistoryData {
  int? identifier;
  int? userID;
  String? clickRef;
  int? retailerID;
  String? retailor;
  String? clickIp;
  String? dateAdded;

  ClickHistoryData({
    this.identifier,
    this.userID,
    this.clickRef,
    this.retailerID,
    this.retailor,
    this.clickIp,
    this.dateAdded,
  });

  ClickHistoryData.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    userID = json['userID'];
    clickRef = json['clickRef'];
    retailerID = json['retailerID'];
    retailor = json['retailor'];
    clickIp = json['clickIp'];
    dateAdded = json['dateAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['userID'] = this.userID;
    data['clickRef'] = this.clickRef;
    data['retailerID'] = this.retailerID;
    data['retailor'] = this.retailor;
    data['clickIp'] = this.clickIp;
    data['dateAdded'] = this.dateAdded;
    return data;
  }
}

class ClickHistoryMeta {
  ClickHistoryPagination? pagination;

  ClickHistoryMeta({
    this.pagination,
  });

  ClickHistoryMeta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? ClickHistoryPagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class ClickHistoryPagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;
  // Links? links;

  ClickHistoryPagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
    // this.links,
  });

  ClickHistoryPagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    // links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    // if (this.links != null) {
    //   data['links'] = this.links!.toJson();
    // }
    return data;
  }
}

// class Links {
//   String? next;
//
//   Links({this.next});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     next = json['next'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['next'] = this.next;
//     return data;
//   }
// }
