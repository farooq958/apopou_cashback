import 'package:bloc/bloc.dart';
import 'package:cashback/controller/repository/category_repo.dart';
import 'package:cashback/model/servicesModel/subCategoryModel.dart';
import 'package:equatable/equatable.dart';

part 'sub_category_cubit_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  final CategoryRepo categoryRepo;
  SubCategoryCubit({required this.categoryRepo})
      : super(SubCategoryState.init());

  Future getSubCategory({int? id}) async {
    emit(state.copyWith(
        status: SubCategoryStatus.loading,
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
        error: ""));

    try {
      var res = await categoryRepo.getSubCategory(id: id);

      emit(state.copyWith(
          status: SubCategoryStatus.success, list: res, error: ""));
    } catch (e) {
      emit(state.copyWith(
          status: SubCategoryStatus.error,
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
          error: e.toString()));
    }
  }
}
