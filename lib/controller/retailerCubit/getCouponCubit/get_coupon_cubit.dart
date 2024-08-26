import 'package:bloc/bloc.dart';
import 'package:cashback/controller/repository/retailerRepo.dart';
import 'package:cashback/model/retailer/couponModel.dart';
import 'package:equatable/equatable.dart';

part 'get_coupon_state.dart';

class GetCouponCubit extends Cubit<GetCouponState> {
  final RetailerRepo retailerRepo;
  GetCouponCubit({required this.retailerRepo}) : super(GetCouponState.init());

  Future getCoupon({int? id}) async {
    emit(state.copyWith(status: GetCouponStatus.loading, list: [], error: ''));
    try {
      var res = await retailerRepo.getCoupon(id: id);
      emit(state.copyWith(
          status: GetCouponStatus.success, list: res, error: ''));
    } catch (e) {
      emit(state.copyWith(
          status: GetCouponStatus.success, list: [], error: e.toString()));
    }
  }
}
