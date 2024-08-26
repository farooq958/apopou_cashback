import 'package:bloc/bloc.dart';
import 'package:cashback/controller/repository/retailerRepo.dart';
import 'package:cashback/model/retailer/retailerModel.dart';
import 'package:equatable/equatable.dart';

part 'single_retailer_state.dart';

class SingleRetailerCubit extends Cubit<SingleRetailerState> {
  final RetailerRepo retailerRepo;
  SingleRetailerCubit({required this.retailerRepo})
      : super(SingleRetailerState.init());

  Future getSingleRetailer({int? id}) async {
    emit(state.copyWith(
        status: SingleRetailerStatus.loading,
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
        error: ""));

    try {
      var res = await retailerRepo.getSingleRetailer(id: id);
      emit(state.copyWith(
          status: SingleRetailerStatus.success, list: res, error: ""));
    } catch (e) {

      emit(state.copyWith(
          status: SingleRetailerStatus.error,
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
          error: e.toString()));
      throw e;
    }
  }
}
