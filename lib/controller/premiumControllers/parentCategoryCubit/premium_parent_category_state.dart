part of 'premium_parent_category_cubit.dart';

enum ParentCategoryStatus {
  initial,
  loading,
  success,
  error,
}

class PremiumParentCategoryState extends Equatable {
  final ParentCategoryStatus status;
  final PremiumParentCategoryModel model;

  PremiumParentCategoryState({
    required this.status,
    required this.model,
  });

  factory PremiumParentCategoryState.initial() {
    return PremiumParentCategoryState(
      status: ParentCategoryStatus.initial,
      model: PremiumParentCategoryModel(data: []),
    );
  }

  @override
  List<Object?> get props => [status, model];

  PremiumParentCategoryState copyWith({
    ParentCategoryStatus? status,
    PremiumParentCategoryModel? model,
  }) {
    return PremiumParentCategoryState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
