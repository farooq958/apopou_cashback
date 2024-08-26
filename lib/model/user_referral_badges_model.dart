class UserReferralBadgesModel {
  String? success;
  dynamic refTotalClicks;
  dynamic refTotal;
  dynamic refPendingBonuses;
  dynamic refPaidBonuses;

  UserReferralBadgesModel({
    this.success,
    this.refTotalClicks,
    this.refTotal,
    this.refPendingBonuses,
    this.refPaidBonuses,
  });

  factory UserReferralBadgesModel.fromJson(Map<String, dynamic> json) {
    return UserReferralBadgesModel(
      success: json["success"],
      refTotalClicks: json["refTotalClicks"] is int
          ? int.parse(json["refTotalClicks"].toString())
          : json["refTotalClicks"].toString(),
      refTotal: json["refTotal"] is int
          ? int.parse(json["refTotal"].toString())
          : json["refTotal"].toString(),
      refPendingBonuses: json["refPendingBonuses"] is int
          ? int.parse(json["refPendingBonuses"].toString())
          : double.parse(json["refPendingBonuses"].toString()),
      refPaidBonuses: json["refPaidBonuses"] is int
          ? int.parse(json["refPaidBonuses"].toString())
          : double.parse(json["refPaidBonuses"].toString()),
    );
    // success = json['success'];
    // refTotalClicks = json['refTotalClicks'];
    // refTotal = json['refTotal'];
    // refPendingBonuses = json['refPendingBonuses'];
    // refPaidBonuses = json['refPaidBonuses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['refTotalClicks'] = this.refTotalClicks;
    data['refTotal'] = this.refTotal;
    data['refPendingBonuses'] = this.refPendingBonuses;
    data['refPaidBonuses'] = this.refPaidBonuses;
    return data;
  }
}
