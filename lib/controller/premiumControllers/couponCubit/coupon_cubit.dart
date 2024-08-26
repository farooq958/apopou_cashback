// import 'package:bloc/bloc.dart';
// import 'package:cashback/controller/premiumControllers/Services/coupon_service.dart';
// import 'package:cashback/model/premium/coupon_model.dart';
// import 'package:equatable/equatable.dart';
//
// part 'coupon_state.dart';
//
// class CouponCubit extends Cubit<CouponState> {
//   final PremiumCouponService service;
//   CouponCubit({
//     required this.service,
//   }) : super(CouponState.initial());
//
//   Future<PremiumCouponModel> getCoupons(String id) async {
//     emit(state.copyWith(
//       status: CouponStatus.loading,
//       model: PremiumCouponModel(data: []),
//     ));
//
//     try {
//       var res = await service.getCoupons(id);
//       emit(state.copyWith(
//         status: CouponStatus.success,
//         model: res,
//       ));
//       return res;
//     } catch (e) {
//       emit(state.copyWith(
//         status: CouponStatus.error,
//         model: PremiumCouponModel(data: []),
//       ));
//       return PremiumCouponModel(data: []);
//     }
//   }
// }
