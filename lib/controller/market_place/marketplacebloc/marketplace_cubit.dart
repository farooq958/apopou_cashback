import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cashback/model/market/marketPlace.dart';
import 'package:equatable/equatable.dart';

import '../../repository/marketplace_Repo.dart';

part 'marketplace_state.dart';

class MarketplaceCubit extends Cubit<MarketplaceState> {
  final MarketPlaceCategoryResposity marketPlaceCategoryResposity;

  MarketplaceCubit({
    required this.marketPlaceCategoryResposity,
  }) : super(MarketplaceState.init());

  Future<bool> MarketPlace(id) async {
    emit(state.copyWith(
        status: MarketplaceStatus.loading, error: "", marketPlaceList: []));

    try {
      var res = await marketPlaceCategoryResposity.MarketPlaceRepository(id);
      emit(state.copyWith(
          status: MarketplaceStatus.success, error: "", marketPlaceList: res));
      return true;
    } catch (e) {
      emit(state.copyWith(
          status: MarketplaceStatus.error,
          error: "cubit patch error from api"));
      return false;
    }
  }
}
