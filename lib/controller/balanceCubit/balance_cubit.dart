import 'package:bloc/bloc.dart';
import 'package:cashback/controller/services/Balance/balance_service.dart';
import 'package:equatable/equatable.dart';
import '../../model/balance/balance_model.dart';
part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final BalanceService service;
  BalanceCubit({
    required this.service,
  }) : super(BalanceState.initial());
  Future<BalanceModel> getBalance() async {
    emit(state.copyWith(status: BalanceStatus.loading, model: BalanceModel()));
    try {
      var res = await service.getBalance();
      emit(state.copyWith(status: BalanceStatus.success, model: res));
      return res;
    } catch (e) {
      emit(state.copyWith(status: BalanceStatus.error, model: BalanceModel()));
      return BalanceModel();
    }
  }
}
