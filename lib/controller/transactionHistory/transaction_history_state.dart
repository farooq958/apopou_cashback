// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_history_cubit.dart';

enum TransactionHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class TransactionHistoryState extends Equatable {
  final TransactionHistoryStatus status;
  final TransectionHistoryModel modelList;
  TransactionHistoryState({
    required this.status,
    required this.modelList,
  });

  factory TransactionHistoryState.initial() {
    return TransactionHistoryState(
      status: TransactionHistoryStatus.initial,
      modelList: TransectionHistoryModel(),
    );
  }

  @override
  List<Object?> get props => [status, modelList];

  TransactionHistoryState copyWith({
    TransactionHistoryStatus? status,
    TransectionHistoryModel? modelList,
  }) {
    return TransactionHistoryState(
      status: status ?? this.status,
      modelList: modelList ?? this.modelList,
    );
  }
}
