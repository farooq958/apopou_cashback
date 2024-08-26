part of 'get_coupon_cubit.dart';

enum GetCouponStatus { initial, loading, success, error }

class GetCouponState extends Equatable {
  final GetCouponStatus status;
  final List<CouponModel> list;
  final String error;
  GetCouponState({
    required this.status,
    required this.list,
    required this.error,
  });

  factory GetCouponState.init() {
    return GetCouponState(status: GetCouponStatus.initial, list: [], error: "");
  }

  @override
  List<Object> get props => [status, list, error];

  @override
  String toString() =>
      'GetCouponState(status: $status, list: $list, error: $error)';

  GetCouponState copyWith({
    GetCouponStatus? status,
    List<CouponModel>? list,
    String? error,
  }) {
    return GetCouponState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }
}
