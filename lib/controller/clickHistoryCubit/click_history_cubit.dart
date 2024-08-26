import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cashback/controller/services/Balance/click_history_service.dart';
import 'package:cashback/model/balance/click_history_model.dart';
import 'package:equatable/equatable.dart';
part 'click_history_state.dart';

class ClickHistoryCubit extends Cubit<ClickHistoryState> {
  final ClickHistoryService service;
  ClickHistoryCubit({
    required this.service,
  }) : super(ClickHistoryState.initial());

  var currentPage;

  Future<ClickHistoryModel> getClickHistory(id, String pageNumber) async {
    if (pageNumber == "1") {
      emit(state.copyWith(
          status: ClickHistoryStatus.loading,
          modelList: ClickHistoryModel(
            data: [],
            meta: ClickHistoryMeta(pagination: ClickHistoryPagination()),
          )));
    }
    try {
      var res = await service.getClickHistory(id, pageNumber);
      currentPage = res.meta!.pagination!.currentPage!;
      emit(state.copyWith(status: ClickHistoryStatus.success, modelList: res));
      return res;
    } catch (e) {
      log("Cubit Error $e");
      emit(state.copyWith(
          status: ClickHistoryStatus.error,
          modelList: ClickHistoryModel(
            data: [],
            meta: ClickHistoryMeta(pagination: ClickHistoryPagination()),
          )));
      return ClickHistoryModel(
        data: [],
        meta: ClickHistoryMeta(pagination: ClickHistoryPagination()),
      );
    }
  }
}
