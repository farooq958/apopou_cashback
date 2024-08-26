// part of 'coupon_cubit.dart';
//
// enum CouponStatus {
//   initial,
//   loading,
//   success,
//   error,
// }
//
// class CouponState extends Equatable {
//   final CouponStatus status;
//   final PremiumCouponModel model;
//
//   CouponState({
//     required this.status,
//     required this.model,
//   });
//
//   factory CouponState.initial() {
//     return CouponState(
//       status: CouponStatus.initial,
//       model: PremiumCouponModel(data: []),
//     );
//   }
//
//   @override
//   List<Object?> get props => [status, model];
//
//   CouponState copyWith({
//     CouponStatus? status,
//     PremiumCouponModel? model,
//   }) {
//     return CouponState(
//       status: status ?? this.status,
//       model: model ?? this.model,
//     );
//   }
// }
