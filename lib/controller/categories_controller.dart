import 'package:cashback/model/categories_model.dart';

class CategoriesController {
  static CategoriesModel data = CategoriesModel(
      meta: Meta(
          pagination: Pagination(
              currentPage: 0,
              perPage: 0,
              count: 0,
              total: 9,
              totalPages: 34,
              links: Links())),
      data: []);
}
