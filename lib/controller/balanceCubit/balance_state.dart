// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'balance_cubit.dart';

enum BalanceStatus {
  initial,
  loading,
  success,
  error,
}

class BalanceState extends Equatable {
  final BalanceStatus status;
  final BalanceModel model;
  BalanceState({
    required this.status,
    required this.model,
  });
  factory BalanceState.initial() {
    return BalanceState(status: BalanceStatus.initial, model: BalanceModel());
  }

  @override
  List<Object?> get props => [status, model];

  BalanceState copyWith({
    BalanceStatus? status,
    BalanceModel? model,
  }) {
    return BalanceState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
