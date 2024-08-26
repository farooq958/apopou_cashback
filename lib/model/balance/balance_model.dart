class BalanceModel {
  String? success;
  String? totalBalance;
  String? pendingBalance;
  String? declineBalance;
  String? WithdrawnAmount;
  String? pendingPayments;
  String? confirmPayments;
  BalanceModel({
    this.success,
    this.totalBalance,
    this.pendingBalance,
    this.declineBalance,
    this.WithdrawnAmount,
    this.pendingPayments,
    this.confirmPayments,
  });

  factory BalanceModel.fromMap(Map<String, dynamic> map) {
    return BalanceModel(
      // success: map['success'],
      // totalBalance: map['total_balance'] == 0
      //     ? "0"
      //     : map['total_balance'].round().toString(),
      // pendingBalance:
      //     map['pending_balance'] == 0 ? "0" : map['pending_balance'],
      // declineBalance:
      //     map['declined_balance'] == 0 ? "0" : map['declined_balance'],
      // WithdrawnAmount:
      //     map['withdrawn_balance'] == 0 ? "0" : map['withdrawn_balance'],
      // pendingPayments:
      //     map['pending_payment'] == 0 ? "0" : map['pending_payment'],

      success: map['success'],
      totalBalance:
          map['total_balance'] == 0 ? "0" : (map['total_balance']).toString(),
      pendingBalance:
          map['pending_balance'] == 0 ? "0" : map['pending_balance'],
      declineBalance:
          map['declined_balance'] == 0 ? "0" : map['declined_balance'],
      WithdrawnAmount:
          map['withdrawn_balance'] == 0 ? "0" : map['withdrawn_balance'],
      pendingPayments:
          map['pending_payment'] == 0 ? "0" : map['pending_payment'],
      confirmPayments:
          map['confirm_payment'] == 0 ? "0" : map['confirm_payment'],
    );
  }
}
