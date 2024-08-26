// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_password_cubit.dart';

enum ChangePasswordStatus {
  initial,
  loading,
  success,
  error,
}

class ChangePasswordState extends Equatable {
  final ChangePasswordStatus status;
  ChangePasswordState({
    required this.status,
  });

  factory ChangePasswordState.initial() {
    return ChangePasswordState(status: ChangePasswordStatus.initial);
  }

  @override
  List<Object?> get props => [status];

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
    );
  }
}
