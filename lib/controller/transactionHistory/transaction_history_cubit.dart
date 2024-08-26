import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cashback/controller/services/Balance/transaction_history_service.dart';
import 'package:equatable/equatable.dart';
import '../../model/balance/transaction_history_model.dart';
part 'transaction_history_state.dart';

class TransactionHistoryCubit extends Cubit<TransactionHistoryState> {
  final TransactionHistoryService service;
  TransactionHistoryCubit({
    required this.service,
  }) : super(TransactionHistoryState.initial());

  // List<TransectionHistoryModel> confirmList = List.empty(growable: true);
  // List<TransectionHistoryModel> paidList = List.empty(growable: true);
  // List<TransectionHistoryModel> pendingList = List.empty(growable: true);

  // Future<List<TransectionHistoryModel>> filterData(
  //     List<TransectionHistoryModel> list) async {
  //   confirmList = list
  //       .where((element) => element.data!.map((e) => e.status) == "confirmed")
  //       .toList();
  //   paidList = list
  //       .where((element) => element.data!.map((e) => e.status) == "paid")
  //       .toList();
  //   pendingList = list
  //       .where((element) => element.data!.map((e) => e.status) == "pending")
  //       .toList();
  //   return list;
  // }
  var currentPage;

  Future init() async {
    emit(state.copyWith(
      status: TransactionHistoryStatus.initial,
      modelList: TransectionHistoryModel(),
    ));
  }

  Future<TransectionHistoryModel> getTransactionHistory(
      {String? pageNumber, String? status}) async {
    if (pageNumber == "1") {
      emit(state.copyWith(
        status: TransactionHistoryStatus.loading,
        modelList: TransectionHistoryModel(
            data: [], meta: TransectionMeta(pagination: Pagination())),
      ));
    }
    try {
      var res = await service.getTrans(status: status, pageNumber: pageNumber);
      //filterData(res);
      currentPage = res.meta!.pagination!.currentPage!;
      emit(state.copyWith(
        status: TransactionHistoryStatus.success,
        modelList: res,
      ));
      return res;
    } catch (e) {
      emit(state.copyWith(
        status: TransactionHistoryStatus.error,
        modelList: TransectionHistoryModel(
            data: [], meta: TransectionMeta(pagination: Pagination())),
      ));
      return TransectionHistoryModel(
          data: [], meta: TransectionMeta(pagination: Pagination()));
    }
  }
}
