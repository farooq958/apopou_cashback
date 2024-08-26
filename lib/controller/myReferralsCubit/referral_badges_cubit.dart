import 'package:bloc/bloc.dart';
import 'package:cashback/controller/services/user_referrals_badges_service.dart';
import 'package:cashback/model/user_referral_badges_model.dart';
import 'package:equatable/equatable.dart';
part 'referral_badges_state.dart';

class ReferralBadgesCubit extends Cubit<ReferralBadgesState> {
  final UserReferralBadgesService service;
  ReferralBadgesCubit({
    required this.service,
  }) : super(ReferralBadgesState.initial());
  Future<UserReferralBadgesModel> getBadges() async {
    emit(state.copyWith(
      status: ReferralBadgesStatus.loading,
      model: UserReferralBadgesModel(),
    ));
    try {
      var res = await service.getBadges();
      emit(state.copyWith(
        status: ReferralBadgesStatus.success,
        model: res,
      ));
      return res;
    } catch (e) {
      emit(state.copyWith(
        status: ReferralBadgesStatus.success,
        model: UserReferralBadgesModel(),
      ));
      return UserReferralBadgesModel();
    }
  }
}
