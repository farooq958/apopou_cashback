import 'package:cashback/controller/services/category_services.dart';
import 'package:cashback/model/servicesModel/parentCategory.dart';
import 'package:cashback/model/servicesModel/subCategoryModel.dart';

class CategoryRepo {
  final CategoryServices categoryServices;
  CategoryRepo({
    required this.categoryServices,
  });

  Future<List<ParentCategory>> getParentCategory() async {
    try {
      var res = await categoryServices.getParentCategory();
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SubCategoryModel> getSubCategory({int? id}) async {
    try {
      var res = await categoryServices.getSubCategory(id: id);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
