import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:cashback/controller/repository/category_repo.dart';
import 'package:cashback/model/servicesModel/parentCategory.dart';

part 'parent_category_state.dart';

class ParentCategoryCubit extends Cubit<ParentCategoryState> {
  final CategoryRepo categoryRepo;
  ParentCategoryCubit({
    required this.categoryRepo,
  }) : super(ParentCategoryState.init());

  Future getParentCategory() async {
    emit(state.copyWith(
        status: ParentCategoryStatus.loading, list: [], error: ""));

    try {
      var res = await categoryRepo.getParentCategory();

      emit(state.copyWith(
          status: ParentCategoryStatus.success, list: res, error: ""));
    } catch (e) {
      emit(state.copyWith(
          status: ParentCategoryStatus.error, list: [], error: e.toString()));
    }
  }
}
