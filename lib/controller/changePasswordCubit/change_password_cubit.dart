import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../services/change_password.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordService service;
  ChangePasswordCubit({
    required this.service,
  }) : super(ChangePasswordState.initial());

  Future<bool> ChangePassword(
    String currentPassword,
    String newPassword,
  ) async {
    emit(state.copyWith(status: ChangePasswordStatus.loading));
    try {
      var res = await service.ChangePassword(currentPassword, newPassword);
      emit(state.copyWith(status: ChangePasswordStatus.success));
      log("Cubit Response $res");
      return res;
    } catch (e) {
      emit(state.copyWith(status: ChangePasswordStatus.error));
      return false;
    }
  }
}
