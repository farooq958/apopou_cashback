// class TransectionHistoryModel {
//   final int identifier;
//   final int userId;
//   final int retailerId;
//   final int referenceId;
//   final int networkId;
//   final int programId;
//   final int referralId;
//   final String retailer;
//   final String paymentType;
//   final String paymentMethod;
//   final String paymentDetails;
//   final int transectionAmount;
//   final int transectionCommision;
//   final double amount;
//   final String reason;
//   final String notificationSent;
//   final String status;
//   final String createdOnDate;
//   final String updatedOnDate;
//   final String processedOnDate;
//   final String statusLabeled;
//   TransectionHistoryModel({
//     required this.identifier,
//     required this.userId,
//     required this.retailerId,
//     required this.referenceId,
//     required this.networkId,
//     required this.programId,
//     required this.referralId,
//     required this.retailer,
//     required this.paymentType,
//     required this.paymentMethod,
//     required this.paymentDetails,
//     required this.transectionAmount,
//     required this.transectionCommision,
//     required this.amount,
//     required this.reason,
//     required this.notificationSent,
//     required this.status,
//     required this.createdOnDate,
//     required this.updatedOnDate,
//     required this.processedOnDate,
//     required this.statusLabeled,
//   });

//   factory TransectionHistoryModel.fromMap(Map<String, dynamic> map) {
//     return TransectionHistoryModel(
//       identifier: map['identifier'] as int,
//       userId: map['userID'] as int,
//       retailerId: map['retailerID'] as int,
//       referenceId: map['referenceID'] as int,
//       networkId: map['networkID'] as int,
//       programId: map['programID'] as int,
//       referralId: map['referralID'] as int,
//       retailer: map['retailer'] as String,
//       paymentType: map['payment_type'] as String,
//       paymentMethod: map['payment_method'] as String,
//       paymentDetails: map['payment_details'] as String,
//       transectionAmount: map['transaction_amount'] as int,
//       transectionCommision: map['transaction_commision'] as int,
//       amount: double.parse("${map['amount']}"),
//       reason: map['reason'] as String,
//       notificationSent: map['notification_sent'] as String,
//       status: map['status'] as String,
//       createdOnDate: map['createdOnDate'] as String,
//       updatedOnDate: map['updatedOnDate'] as String,
//       processedOnDate: map['processedOnDate'] as String,
//       statusLabeled: map["statuslabeled"] as String,
//     );
//   }
// }

class TransectionHistoryModel {
  List<TransectionData>? data;
  TransectionMeta? meta;

  TransectionHistoryModel({this.data, this.meta});

  TransectionHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TransectionData>[];
      json['data'].forEach((v) {
        data!.add(new TransectionData.fromJson(v));
      });
    }
    meta = json['meta'] != null
        ? new TransectionMeta.fromJson(json['meta'])
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

class TransectionData {
  int? identifier;
  int? userID;
  int? retailerID;
  String? referenceID;
  int? networkID;
  int? programID;
  int? referralID;
  String? retailer;
  String? paymentType;
  String? paymentMethod;
  String? paymentDetails;
  double? transactionAmount;
  int? transactionCommision;
  double? amount;
  String? reason;
  String? notificationSent;
  String? status;
  String? createdOnDate;
  String? updatedOnDate;
  String? processedOnDate;
  String? typelabeled;
  String? statuslabeled;

  TransectionData(
      {this.identifier,
      this.userID,
      this.retailerID,
      this.referenceID,
      this.networkID,
      this.programID,
      this.referralID,
      this.retailer,
      this.paymentType,
      this.paymentMethod,
      this.paymentDetails,
      this.transactionAmount,
      this.transactionCommision,
      this.amount,
      this.reason,
      this.notificationSent,
      this.status,
      this.createdOnDate,
      this.updatedOnDate,
      this.processedOnDate,
      this.typelabeled,
      this.statuslabeled});

  TransectionData.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    userID = json['userID'];
    retailerID = json['retailerID'];
    referenceID = json['referenceID'];
    networkID = json['networkID'];
    programID = json['programID'];
    referralID = json['referralID'];
    retailer = json['retailer'];
    paymentType = json['payment_type'];
    paymentMethod = json['payment_method'];
    paymentDetails = json['payment_details'];
    transactionAmount = double.parse(json['transaction_amount'].toString());
    transactionCommision = json['transaction_commision'];
    amount = double.parse(json['amount'].toString());
    reason = json['reason'];
    notificationSent = json['notification_sent'];
    status = json['status'];
    createdOnDate = json['createdOnDate'];
    updatedOnDate = json['updatedOnDate'];
    processedOnDate = json['processedOnDate'];
    typelabeled = json['typelabeled'];
    statuslabeled = json['statuslabeled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['userID'] = this.userID;
    data['retailerID'] = this.retailerID;
    data['referenceID'] = this.referenceID;
    data['networkID'] = this.networkID;
    data['programID'] = this.programID;
    data['referralID'] = this.referralID;
    data['retailer'] = this.retailer;
    data['payment_type'] = this.paymentType;
    data['payment_method'] = this.paymentMethod;
    data['payment_details'] = this.paymentDetails;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_commision'] = this.transactionCommision;
    data['amount'] = this.amount;
    data['reason'] = this.reason;
    data['notification_sent'] = this.notificationSent;
    data['status'] = this.status;
    data['createdOnDate'] = this.createdOnDate;
    data['updatedOnDate'] = this.updatedOnDate;
    data['processedOnDate'] = this.processedOnDate;
    data['typelabeled'] = this.typelabeled;
    data['statuslabeled'] = this.statuslabeled;
    return data;
  }
}

class TransectionMeta {
  Pagination? pagination;

  TransectionMeta({this.pagination});

  TransectionMeta.fromJson(Map<String, dynamic> json) {
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
  String? previous;
  String? next;

  Links({this.previous, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    previous = json['previous'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['previous'] = this.previous;
    data['next'] = this.next;
    return data;
  }
}
