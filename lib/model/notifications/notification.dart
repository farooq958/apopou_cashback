import 'dart:convert';
import 'package:equatable/equatable.dart';

///Old model
// class NotificationModel extends Equatable {
//   final int identifier;
//   final int user_id;
//   final String title;
//   final String text;
//   final int seen;
//   final String created_at;
//
//   NotificationModel({
//     required this.identifier,
//     required this.user_id,
//     required this.title,
//     required this.text,
//     required this.seen,
//     required this.created_at,
//   });
//
//   NotificationModel copyWith({
//     int? identifier,
//     int? user_id,
//     String? title,
//     String? text,
//     int? seen,
//     String? created_at,
//   }) {
//     return NotificationModel(
//       identifier: identifier ?? this.identifier,
//       user_id: user_id ?? this.user_id,
//       title: title ?? this.title,
//       text: text ?? this.text,
//       seen: seen ?? this.seen,
//       created_at: created_at ?? this.created_at,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'identifier': identifier,
//       'user_id': user_id,
//       'title': title,
//       'text': text,
//       'seen': seen,
//       'created_at': created_at,
//     };
//   }
//
//   factory NotificationModel.fromMap(Map<String, dynamic> map) {
//     return NotificationModel(
//       identifier: map['identifier']?.toInt() ?? 0,
//       user_id: map['user_id']?.toInt() ?? 0,
//       title: map['title'] ?? '',
//       text: map['text'] ?? '',
//       seen: map['seen']?.toInt() ?? 0,
//       created_at: map['created_at'] ?? '',
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory NotificationModel.fromJson(String source) =>
//       NotificationModel.fromMap(json.decode(source));
//
//   @override
//   String toString() {
//     return 'NotificationModel(identifier: $identifier, user_id: $user_id, title: $title, text: $text, seen: $seen, created_at: $created_at)';
//   }
//
//   @override
//   List<Object> get props {
//     return [
//       identifier,
//       user_id,
//       title,
//       text,
//       seen,
//       created_at,
//     ];
//   }
// }

class NotificationModel {
  List<NotificationDataModel>? data;
  NotificationMetaModel? meta;

  NotificationModel({this.data, this.meta});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotificationDataModel>[];
      json['data'].forEach((v) {
        data?.add(NotificationDataModel.fromJson(v));
      });
    }
    meta = json['meta'] != null
        ? NotificationMetaModel.fromJson(json['meta'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta?.toJson();
    }
    return data;
  }
}

class NotificationDataModel {
  int? identifier;
  int? userId;
  String? title;
  String? text;
  int? seen;
  String? createdAt;

  NotificationDataModel({
    this.identifier,
    this.userId,
    this.title,
    this.text,
    this.seen,
    this.createdAt,
  });

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    userId = json['user_id'];
    title = json['title'];
    text = json['text'];
    seen = json['seen'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['text'] = this.text;
    data['seen'] = this.seen;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class NotificationMetaModel {
  NotificationPaginationModel? pagination;

  NotificationMetaModel({
    this.pagination,
  });

  NotificationMetaModel.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? NotificationPaginationModel.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination?.toJson();
    }
    return data;
  }
}

class NotificationPaginationModel {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;
  NotificationLinksModel? links;

  NotificationPaginationModel({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.links,
  });

  NotificationPaginationModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    links = json['links'] != null
        ? new NotificationLinksModel.fromJson(json['links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    if (this.links != null) {
      data['links'] = this.links?.toJson();
    }
    return data;
  }
}

class NotificationLinksModel {
  String? next;

  NotificationLinksModel({
    this.next,
  });

  NotificationLinksModel.fromJson(Map<String, dynamic> json) {
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['next'] = this.next;
    return data;
  }
}
