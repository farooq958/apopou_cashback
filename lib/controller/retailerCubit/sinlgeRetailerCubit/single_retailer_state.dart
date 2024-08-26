part of 'single_retailer_cubit.dart';

enum SingleRetailerStatus { initial, loading, success, error }

class SingleRetailerState extends Equatable {
  final SingleRetailerStatus status;
  final RetailerModel list;
  final String error;
  SingleRetailerState({
    required this.status,
    required this.list,
    required this.error,
  });

  factory SingleRetailerState.init() {
    return SingleRetailerState(
        status: SingleRetailerStatus.initial,
        list: RetailerModel(
            identifier: 0,
            networkID: 0,
            networkProgramID: "",
            storeName: "",
            redirectURL: "",
            storeImgURL: "",
            storeCashback: "",
            storeTerms: "",
            shortDescription: "",
            storeDomain: "",
            storeTags: "",
            headTitle: "",
            metaDescription: "",
            shippingInfo: "",
            featuredStore: 0,
            storeOfWeek: 0,
            noOfVisits: 0,
            mobileVisits: 0,
            status: "",
            favoriters: 0,
            flatShippingAmount: 0,
            aboveFlatShippingAmount: 0,
            apopouCommissionPercent: 0,
            expiringDate: "",
            createdOnDate: "",
            coupons_count: 0,
            products_count: 0),
        error: "");
  }

  @override
  String toString() =>
      'SingleRetailerState(status: $status, list: $list, error: $error)';

  @override
  List<Object> get props => [status, list, error];

  SingleRetailerState copyWith({
    SingleRetailerStatus? status,
    RetailerModel? list,
    String? error,
  }) {
    return SingleRetailerState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }
}
