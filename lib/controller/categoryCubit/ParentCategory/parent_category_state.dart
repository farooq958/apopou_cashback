part of 'parent_category_cubit.dart';

enum ParentCategoryStatus { initial, loading, success, error }

class ParentCategoryState extends Equatable {
  final ParentCategoryStatus status;
  final List<ParentCategory> list;
  final String error;

  ParentCategoryState({
    required this.status,
    required this.list,
    required this.error,
  });

  factory ParentCategoryState.init() {
    return ParentCategoryState(
        status: ParentCategoryStatus.initial, list: [], error: "");
  }

  @override
  List<Object> get props => [status, list, error];

  ParentCategoryState copyWith({
    ParentCategoryStatus? status,
    List<ParentCategory>? list,
    String? error,
  }) {
    return ParentCategoryState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'ParentCategoryState(status: $status, list: $list, error: $error)';
}
