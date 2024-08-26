import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cashback/controller/services/user_referral_service.dart';
import 'package:cashback/model/user_referral_model.dart';
import 'package:equatable/equatable.dart';
part 'my_referrals_state.dart';

class MyReferralsCubit extends Cubit<MyReferralsState> {
  final UserReferralService service;
  MyReferralsCubit({
    required this.service,
  }) : super(MyReferralsState.initial());

  var currentPage;

  Future<UserReferralModel> getUserReferral(String pageNumber) async {
    if (pageNumber == "1") {
      emit(state.copyWith(
          status: MyReferralStatus.loading,
          model: UserReferralModel(data: [])));
    }
    try {
      var res = await service.getUserReferral(pageNumber);
      // if (res.toString().contains("current_page")) {
      currentPage = res.meta!.pagination!.currentPage!;
      // }
      emit(state.copyWith(status: MyReferralStatus.success, model: res));
      return res;
    } catch (e) {
      emit(state.copyWith(
          status: MyReferralStatus.error,
          model: UserReferralModel(
            data: [],
          )));
      return UserReferralModel(
        data: [],
      );
    }
  }
}
