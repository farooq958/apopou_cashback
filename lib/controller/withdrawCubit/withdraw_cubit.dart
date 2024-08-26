import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../services/withdraw_service.dart';
part 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawState> {
  final WithDrawService service;
  WithdrawCubit({
    required this.service,
  }) : super(WithdrawState.initial());

  Future<Map<String, dynamic>> WithDrawPayment(Map<String, dynamic> map) async {
    emit(state.copyWith(status: WithDrawStatus.loading));
    try {
      // responseMap = await WithDrawService.extra({});
      // if (responseMap["min_payout"] is List ||
      //     responseMap["low_balance"] is List) {
      //   log("${responseMap['min_payout'][0]} ${responseMap['low_balance'][0]}");
      // }
      var res = await service.WithDrawPayment(map);
      if (res["min_payout"] is List || res["low_balance"] is List) {
        emit(state.copyWith(status: WithDrawStatus.error));
        return res;
      } else {
        emit(state.copyWith(status: WithDrawStatus.success));
        return res;
      }
    } catch (e) {
      emit(state.copyWith(status: WithDrawStatus.error));
      log("CUBIT ERROR $e");
      return {};
    }
  }
}
