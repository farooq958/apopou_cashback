import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cashback/model/user_model.dart';
import 'package:equatable/equatable.dart';

import '../../services/user_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService service;
  UserCubit({
    required this.service,
  }) : super(UserState.initial());

  Future initial() async {
    emit(state.copyWith(status: UserStatus.initial, model: UserModel()));
  }

  Future<UserModel> getUser() async {
    emit(state.copyWith(status: UserStatus.loading, model: UserModel()));
    try {
      var res = await service.getUserData();
      emit(state.copyWith(status: UserStatus.success, model: res));
      log("Cubit res $res");
      return res;
    } catch (e) {
      emit(state.copyWith(status: UserStatus.error, model: UserModel()));
      log(e.toString());
      return UserModel();
    }
  }
}
