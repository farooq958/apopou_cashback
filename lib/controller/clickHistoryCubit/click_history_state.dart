// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'click_history_cubit.dart';

enum ClickHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class ClickHistoryState extends Equatable {
  final ClickHistoryStatus status;
  final ClickHistoryModel modelList;
  ClickHistoryState({
    required this.status,
    required this.modelList,
  });

  factory ClickHistoryState.initial() {
    return ClickHistoryState(
      status: ClickHistoryStatus.initial,
      modelList: ClickHistoryModel(
        data: [],
        meta: ClickHistoryMeta(pagination: ClickHistoryPagination()),
      ),
    );
  }

  @override
  List<Object?> get props => [status, modelList];

  ClickHistoryState copyWith({
    ClickHistoryStatus? status,
    ClickHistoryModel? modelList,
  }) {
    return ClickHistoryState(
      status: status ?? this.status,
      modelList: modelList ?? this.modelList,
    );
  }
}
