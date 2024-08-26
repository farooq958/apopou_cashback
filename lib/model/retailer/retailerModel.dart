import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';

class RetailerModel extends Equatable {
  final int identifier;
  final int networkID;
  final String networkProgramID;
  final String storeName;
  final String redirectURL;
  final String storeImgURL;
  final String storeCashback;
  final String storeTerms;
  final String shortDescription;
  final String storeDomain;
  final String storeTags;
  final String headTitle;
  final String metaDescription;
  final String shippingInfo;
  final int featuredStore;
  final int storeOfWeek;
  final int noOfVisits;
  final int mobileVisits;
  final String status;
  final int favoriters;
  final int flatShippingAmount;
  final int aboveFlatShippingAmount;
  final int apopouCommissionPercent;
  final String expiringDate;
  final String createdOnDate;
  final int coupons_count;
  final int products_count;
  RetailerModel({
    required this.identifier,
    required this.networkID,
    required this.networkProgramID,
    required this.storeName,
    required this.redirectURL,
    required this.storeImgURL,
    required this.storeCashback,
    required this.storeTerms,
    required this.shortDescription,
    required this.storeDomain,
    required this.storeTags,
    required this.headTitle,
    required this.metaDescription,
    required this.shippingInfo,
    required this.featuredStore,
    required this.storeOfWeek,
    required this.noOfVisits,
    required this.mobileVisits,
    required this.status,
    required this.favoriters,
    required this.flatShippingAmount,
    required this.aboveFlatShippingAmount,
    required this.apopouCommissionPercent,
    required this.expiringDate,
    required this.createdOnDate,
    required this.coupons_count,
    required this.products_count,
  });

  RetailerModel copyWith({
    int? identifier,
    int? networkID,
    String? networkProgramID,
    String? storeName,
    String? redirectURL,
    String? storeImgURL,
    String? storeCashback,
    String? storeTerms,
    String? shortDescription,
    String? storeDomain,
    String? storeTags,
    String? headTitle,
    String? metaDescription,
    String? shippingInfo,
    int? featuredStore,
    int? storeOfWeek,
    int? noOfVisits,
    int? mobileVisits,
    String? status,
    int? favoriters,
    int? flatShippingAmount,
    int? aboveFlatShippingAmount,
    int? apopouCommissionPercent,
    String? expiringDate,
    String? createdOnDate,
    int? coupons_count,
    int? products_count,
  }) {
    return RetailerModel(
      identifier: identifier ?? this.identifier,
      networkID: networkID ?? this.networkID,
      networkProgramID: networkProgramID ?? this.networkProgramID,
      storeName: storeName ?? this.storeName,
      redirectURL: redirectURL ?? this.redirectURL,
      storeImgURL: storeImgURL ?? this.storeImgURL,
      storeCashback: storeCashback ?? this.storeCashback,
      storeTerms: storeTerms ?? this.storeTerms,
      shortDescription: shortDescription ?? this.shortDescription,
      storeDomain: storeDomain ?? this.storeDomain,
      storeTags: storeTags ?? this.storeTags,
      headTitle: headTitle ?? this.headTitle,
      metaDescription: metaDescription ?? this.metaDescription,
      shippingInfo: shippingInfo ?? this.shippingInfo,
      featuredStore: featuredStore ?? this.featuredStore,
      storeOfWeek: storeOfWeek ?? this.storeOfWeek,
      noOfVisits: noOfVisits ?? this.noOfVisits,
      mobileVisits: mobileVisits ?? this.mobileVisits,
      status: status ?? this.status,
      favoriters: favoriters ?? this.favoriters,
      flatShippingAmount: flatShippingAmount ?? this.flatShippingAmount,
      aboveFlatShippingAmount:
          aboveFlatShippingAmount ?? this.aboveFlatShippingAmount,
      apopouCommissionPercent:
          apopouCommissionPercent ?? this.apopouCommissionPercent,
      expiringDate: expiringDate ?? this.expiringDate,
      createdOnDate: createdOnDate ?? this.createdOnDate,
      coupons_count: coupons_count ?? this.coupons_count,
      products_count: products_count ?? this.products_count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'identifier': identifier,
      'networkID': networkID,
      'networkProgramID': networkProgramID,
      'storeName': storeName,
      'redirectURL': redirectURL,
      'storeImgURL': storeImgURL,
      'storeCashback': storeCashback,
      'storeTerms': storeTerms,
      'shortDescription': shortDescription,
      'storeDomain': storeDomain,
      'storeTags': storeTags,
      'headTitle': headTitle,
      'metaDescription': metaDescription,
      'shippingInfo': shippingInfo,
      'featuredStore': featuredStore,
      'storeOfWeek': storeOfWeek,
      'noOfVisits': noOfVisits,
      'mobileVisits': mobileVisits,
      'status': status,
      'favoriters': favoriters,
      'flatShippingAmount': flatShippingAmount,
      'aboveFlatShippingAmount': aboveFlatShippingAmount,
      'apopouCommissionPercent': apopouCommissionPercent,
      'expiringDate': expiringDate,
      'createdOnDate': createdOnDate,
      'coupons_count': coupons_count,
      'products_count': products_count,
    };
  }

  factory RetailerModel.fromMap(Map<String, dynamic> map) {
    // log("testing map ${map}");
    // var test = RetailerModel(
    //   identifier: map['identifier']?.toInt() ?? 0,
    //   networkID: map['networkID']?.toInt() ?? 0,
    //   networkProgramID: map['networkProgramID'] ?? '',
    //   storeName: map['storeName'] ?? '',
    //   redirectURL: map['redirectURL'] ?? '',
    //   storeImgURL: map['storeImgURL'] ?? '',
    //   storeCashback: map['storeCashback'] ?? '',
    //   storeTerms: map['storeTerms'] ?? '',
    //   shortDescription: map['shortDescription'] ?? '',
    //   storeDomain: map['storeDomain'] ?? '',
    //   storeTags: map['storeTags'] ?? '',
    //   headTitle: map['headTitle'] ?? '',
    //   metaDescription: map['metaDescription'] ?? '',
    //   shippingInfo: map['shippingInfo'] ?? '',
    //   featuredStore: map['featuredStore']?.toInt() ?? 0,
    //   storeOfWeek: map['storeOfWeek']?.toInt() ?? 0,
    //   noOfVisits: map['noOfVisits']?.toInt() ?? 0,
    //   mobileVisits: map['mobileVisits']?.toInt() ?? 0,
    //   status: map['status'] ?? '',
    //   favoriters: map['favoriters']?.toInt() ?? 0,
    //   flatShippingAmount: map['flatShippingAmount']?.toInt() ?? 0,
    //   aboveFlatShippingAmount: map['aboveFlatShippingAmount']?.toInt() ?? 0,
    //   apopouCommissionPercent: map['apopouCommissionPercent']?.toInt() ?? 0,
    //   expiringDate: map['expiringDate'] ?? '',
    //   createdOnDate: map['createdOnDate'] ?? '',
    //   coupons_count: map['coupons_count']?.toInt() ?? 0,
    //   products_count: map['products_count']?.toInt() ?? 0,
    // );
    // log("testing map 2 ${test}");
    return RetailerModel(
      identifier: map['identifier']?.toInt() ?? 0,
      networkID: map['networkID']?.toInt() ?? 0,
      networkProgramID: map['networkProgramID'] ?? '',
      storeName: map['storeName'] ?? '',
      redirectURL: map['redirectURL'] ?? '',
      storeImgURL: map['storeImgURL'] ?? '',
      storeCashback: map['storeCashback'] ?? '',
      storeTerms: map['storeTerms'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      storeDomain: map['storeDomain'] ?? '',
      storeTags: map['storeTags'] ?? '',
      headTitle: map['headTitle'] ?? '',
      metaDescription: map['metaDescription'] ?? '',
      shippingInfo: map['shippingInfo'] ?? '',
      featuredStore: map['featuredStore']?.toInt() ?? 0,
      storeOfWeek: map['storeOfWeek']?.toInt() ?? 0,
      noOfVisits: map['noOfVisits']?.toInt() ?? 0,
      mobileVisits: map['mobileVisits']?.toInt() ?? 0,
      status: map['status'] ?? '',
      favoriters: map['favoriters']?.toInt() ?? 0,
      flatShippingAmount: map['flatShippingAmount']?.toInt() ?? 0,
      aboveFlatShippingAmount: map['aboveFlatShippingAmount']?.toInt() ?? 0,
      apopouCommissionPercent: map['apopouCommissionPercent']?.toInt() ?? 0,
      expiringDate: map['expiringDate'] ?? '',
      createdOnDate: map['createdOnDate'] ?? '',
      coupons_count: map['coupons_count']?.toInt() ?? 0,
      products_count: map['products_count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RetailerModel.fromJson(String source) =>
      RetailerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RetailerModel(identifier: $identifier, networkID: $networkID, networkProgramID: $networkProgramID, storeName: $storeName, redirectURL: $redirectURL, storeImgURL: $storeImgURL, storeCashback: $storeCashback, storeTerms: $storeTerms, shortDescription: $shortDescription, storeDomain: $storeDomain, storeTags: $storeTags, headTitle: $headTitle, metaDescription: $metaDescription, shippingInfo: $shippingInfo, featuredStore: $featuredStore, storeOfWeek: $storeOfWeek, noOfVisits: $noOfVisits, mobileVisits: $mobileVisits, status: $status, favoriters: $favoriters, flatShippingAmount: $flatShippingAmount, aboveFlatShippingAmount: $aboveFlatShippingAmount, apopouCommissionPercent: $apopouCommissionPercent, expiringDate: $expiringDate, createdOnDate: $createdOnDate, coupons_count: $coupons_count, products_count: $products_count)';
  }

  @override
  List<Object> get props {
    return [
      identifier,
      networkID,
      networkProgramID,
      storeName,
      redirectURL,
      storeImgURL,
      storeCashback,
      storeTerms,
      shortDescription,
      storeDomain,
      storeTags,
      headTitle,
      metaDescription,
      shippingInfo,
      featuredStore,
      storeOfWeek,
      noOfVisits,
      mobileVisits,
      status,
      favoriters,
      flatShippingAmount,
      aboveFlatShippingAmount,
      apopouCommissionPercent,
      expiringDate,
      createdOnDate,
      coupons_count,
      products_count,
    ];
  }
}
