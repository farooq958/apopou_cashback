part of 'sub_category_cubit_cubit.dart';

enum SubCategoryStatus { initial, loading, success, error }

class SubCategoryState extends Equatable {
  final SubCategoryStatus status;
  final SubCategoryModel list;
  final String error;

  SubCategoryState({
    required this.status,
    required this.list,
    required this.error,
  });

  factory SubCategoryState.init() {
    return SubCategoryState(
        status: SubCategoryStatus.initial,
        list: SubCategoryModel(
            identifier: 0,
            storeName: "",
            storeImgURL: "",
            storeCashback: "",
            featuredStore: 0,
            noOfVisits: 1,
            favoriters: 1,
            coupons_count: 1,
            products_count: 1,
            sucategories: []),
        error: "");
  }

  @override
  List<Object> get props => [status, list, error];

  SubCategoryState copyWith({
    SubCategoryStatus? status,
    SubCategoryModel? list,
    String? error,
  }) {
    return SubCategoryState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'SubCategoryState(status: $status, list: $list, error: $error)';
}
