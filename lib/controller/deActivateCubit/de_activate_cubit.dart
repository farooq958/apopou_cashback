import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../services/de_activate_account_service.dart';
part 'de_activate_state.dart';

class DeActivateCubit extends Cubit<DeActivateState> {
  final DeActivateService service;
  DeActivateCubit({
    required this.service,
  }) : super(DeActivateState.initial());

  Future<bool> deActivateUser(String email) async {
    emit(state.copyWith(status: DeactivateStatus.loading));
    try {
      var res = await service.deActivateUser(email);
      emit(state.copyWith(status: DeactivateStatus.success));
      return res;
    } catch (e) {
      emit(state.copyWith(status: DeactivateStatus.error));
      return false;
    }
  }
}
