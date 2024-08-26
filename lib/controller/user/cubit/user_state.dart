// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

enum UserStatus {
  initial,
  loading,
  success,
  error,
}

class UserState extends Equatable {
  final UserStatus status;
  final UserModel model;
  UserState({
    required this.status,
    required this.model,
  });

  factory UserState.initial() {
    return UserState(
      status: UserStatus.initial,
      model: UserModel(),
    );
  }
  @override
  List<Object?> get props => [status, model];

  UserState copyWith({
    UserStatus? status,
    UserModel? model,
  }) {
    return UserState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
