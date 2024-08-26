// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'withdraw_cubit.dart';

enum WithDrawStatus {
  initial,
  loading,
  success,
  error,
}

class WithdrawState extends Equatable {
  final WithDrawStatus status;
  WithdrawState({
    required this.status,
  });

  factory WithdrawState.initial() {
    return WithdrawState(status: WithDrawStatus.initial);
  }

  @override
  List<Object?> get props => [status];

  WithdrawState copyWith({
    WithDrawStatus? status,
  }) {
    return WithdrawState(
      status: status ?? this.status,
    );
  }
}
