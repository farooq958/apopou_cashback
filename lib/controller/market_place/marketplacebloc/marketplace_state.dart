part of 'marketplace_cubit.dart';

enum MarketplaceStatus { initial, loading, success, error }

class MarketplaceState extends Equatable {
  MarketplaceStatus status;
  String error;
  List<MarketPlaceModel> marketPlaceList;

  MarketplaceState(
      {required this.error,
      required this.status,
      required this.marketPlaceList});

  factory MarketplaceState.init() {
    return MarketplaceState(
        error: '', status: MarketplaceStatus.initial, marketPlaceList: []);
  }

  @override
  List<Object> get props => [error, status];

  MarketplaceState copyWith({
    MarketplaceStatus? status,
    String? error,
    List<MarketPlaceModel>? marketPlaceList,
  }) {
    return MarketplaceState(
      status: status ?? this.status,
      error: error ?? this.error,
      marketPlaceList: marketPlaceList ?? this.marketPlaceList,
    );
  }
}
