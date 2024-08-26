import 'package:cashback/model/all_featured_model.dart';
class AllFeatureController {
  static AllFeatured data = AllFeatured(
      data: [],
      meta: Meta(
          pagination: Pagination(
              currentPage: 0,
              links: Links(),
              perPage: 0,
              count: 0,
              total: 9,
              totalPages: 34)));
  static List<Datum> listData=[];
  static int page=1;
}
