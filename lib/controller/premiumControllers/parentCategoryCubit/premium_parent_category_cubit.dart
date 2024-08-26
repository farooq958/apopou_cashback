import 'package:bloc/bloc.dart';
import 'package:cashback/controller/premiumControllers/Services/parent_catergory_service.dart';
import 'package:cashback/model/premium/parent_category_model.dart';
import 'package:equatable/equatable.dart';
part 'premium_parent_category_state.dart';

class PremiumParentCategoryCubit extends Cubit<PremiumParentCategoryState> {
  final PremiumParentCategoryService service;
  PremiumParentCategoryCubit({
    required this.service,
  }) : super(PremiumParentCategoryState.initial());

  Future<PremiumParentCategoryModel> getCategories() async {
    emit(state.copyWith(
      status: ParentCategoryStatus.loading,
      model: PremiumParentCategoryModel(data: []),
    ));

    try {
      var res = await service.getCategories();
      emit(state.copyWith(
        status: ParentCategoryStatus.success,
        model: res,
      ));
      return res;
    } catch (e) {
      emit(state.copyWith(
        status: ParentCategoryStatus.error,
        model: PremiumParentCategoryModel(data: []),
      ));
      return PremiumParentCategoryModel(data: []);
    }
  }
}
