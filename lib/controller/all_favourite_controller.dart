
import 'package:cashback/model/favourite_model.dart';

class AllFavouriteController {
  static FavouriteModel data = FavouriteModel(
      data: [],
      meta: Meta(
          pagination: Pagination(
              currentPage: 0,
              links: Links(next: ''),
              perPage: 0,
              count: 0,
              total: 9,
              totalPages: 34)));
  static List<Datum> listData=[];
  static int page=1;
}
