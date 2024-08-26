// class UserReferralModel {
//   List<Data>? data;

//   UserReferralModel({this.data});

//   UserReferralModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }
// }

// class Data {
//   int? identifier;
//   String? fullName;
//   String? fname;
//   String? lname;
//   String? userName;
//   String? contactEmail;
//   String? phoneNumber;
//   String? country;
//   int? isVerified;
//   String? createdOnDate;
//   String? lastModifiedOnDate;
//   String? deletedDate;

//   Data(
//       {this.identifier,
//       this.fullName,
//       this.fname,
//       this.lname,
//       this.userName,
//       this.contactEmail,
//       this.phoneNumber,
//       this.country,
//       this.isVerified,
//       this.createdOnDate,
//       this.lastModifiedOnDate,
//       this.deletedDate});

//   Data.fromJson(Map<String, dynamic> json) {
//     identifier = json['identifier'];
//     fullName = json['full-name'];
//     fname = json['fname'];
//     lname = json['lname'];
//     userName = json['user-name'];
//     contactEmail = json['contact-email'];
//     phoneNumber = json['phone-number'];
//     country = json['country'];
//     isVerified = json['isVerified'];
//     createdOnDate = json['createdOnDate'];
//     lastModifiedOnDate = json['lastModifiedOnDate'];
//     deletedDate = json['deletedDate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['identifier'] = this.identifier;
//     data['full-name'] = this.fullName;
//     data['fname'] = this.fname;
//     data['lname'] = this.lname;
//     data['user-name'] = this.userName;
//     data['contact-email'] = this.contactEmail;
//     data['phone-number'] = this.phoneNumber;
//     data['country'] = this.country;
//     data['isVerified'] = this.isVerified;
//     data['createdOnDate'] = this.createdOnDate;
//     data['lastModifiedOnDate'] = this.lastModifiedOnDate;
//     data['deletedDate'] = this.deletedDate;
//     return data;
//   }
// }

class UserReferralModel {
  List<UserReferralData>? data;
  UserReferralMeta? meta;

  UserReferralModel({this.data, this.meta});

  UserReferralModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserReferralData>[];
      json['data'].forEach((v) {
        data!.add(new UserReferralData.fromJson(v));
      });
    }
    meta = json['meta'] != null
        ? new UserReferralMeta.fromJson(json['meta'])
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

class UserReferralData {
  int? identifier;
  String? fullName;
  String? fname;
  String? lname;
  String? userName;
  String? contactEmail;
  String? phoneNumber;
  String? country;
  int? isVerified;
  String? createdOnDate;
  String? lastModifiedOnDate;
  String? deletedDate;

  UserReferralData(
      {this.identifier,
      this.fullName,
      this.fname,
      this.lname,
      this.userName,
      this.contactEmail,
      this.phoneNumber,
      this.country,
      this.isVerified,
      this.createdOnDate,
      this.lastModifiedOnDate,
      this.deletedDate});

  UserReferralData.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    fullName = json['full-name'];
    fname = json['fname'];
    lname = json['lname'];
    userName = json['user-name'];
    contactEmail = json['contact-email'];
    phoneNumber = json['phone-number'];
    country = json['country'];
    isVerified = json['isVerified'];
    createdOnDate = json['createdOnDate'];
    lastModifiedOnDate = json['lastModifiedOnDate'];
    deletedDate = json['deletedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['full-name'] = this.fullName;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['user-name'] = this.userName;
    data['contact-email'] = this.contactEmail;
    data['phone-number'] = this.phoneNumber;
    data['country'] = this.country;
    data['isVerified'] = this.isVerified;
    data['createdOnDate'] = this.createdOnDate;
    data['lastModifiedOnDate'] = this.lastModifiedOnDate;
    data['deletedDate'] = this.deletedDate;
    return data;
  }
}

class UserReferralMeta {
  Pagination? pagination;

  UserReferralMeta({this.pagination});

  UserReferralMeta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
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

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;
  Links? links;

  Pagination(
      {this.total,
      this.count,
      this.perPage,
      this.currentPage,
      this.totalPages,
      this.links});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Links {
  String? next;

  Links({this.next});

  Links.fromJson(Map<String, dynamic> json) {
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    return data;
  }
}
