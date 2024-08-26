

import 'package:cashback/model/all_shops_model.dart';
import 'package:get/get.dart';
class AllProductsController {
  static AllStores data = AllStores(
      data: [],
      meta: Meta(
          pagination: Pagination(
              currentPage: 0,
              links: Links(next: ''),
              perPage: 0,
              count: 0,
              total: 2,
              totalPages: 2)));
  static int page=1;
  static List<AllStoresDatum> listData=[];
}



