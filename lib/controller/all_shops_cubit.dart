import 'package:bloc/bloc.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/all_shops_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'all_products_controller.dart';
import 'services/apis.dart';
part 'all_shops_state.dart';

class AllShopsCubit extends Cubit<AllShopsState> {
  AllShopsCubit() : super(AllShopsInitial());

  Future<bool> allShops({required bool reload}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    if (AllProductsController.page <=
        AllProductsController.data.meta.pagination.totalPages) {
      print("page now is " + AllProductsController.page.toString());
      print("total Pages are " +
          AllProductsController.data.meta.pagination.totalPages.toString());
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request = http.Request('GET', Uri.parse(
          // "${checkServer}/api/retailers?include=categories&fields=identifier,storeName,storeImgURL,storeCashback,coupons_count,products_count,favoriters&page=${AllProductsController.page}"));

          "${finalServer}/api/retailers?fields=identifier,storeName,storeImgURL,storeCashback,coupons_count,products_count,favoriters&page=${AllProductsController.page}"));
print("api ");
print("${finalServer}/api/retailers?fields=identifier,storeName,storeImgURL,storeCashback,coupons_count,products_count,favoriters&page=${AllProductsController.page}");
      request.headers.addAll(headers);
      emit(AllShopsLoading());
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String str = await response.stream.bytesToString();
        AllProductsController.data = AllStores.fromRawJson(str);
        print(AllProductsController.data.data.toString());
        //AllProductsController.listData.clear();
        AllProductsController.listData.addAll(AllProductsController.data.data);
        AllProductsController.page = AllProductsController.page + 1;
        print("length of data before ");
        print(AllProductsController.listData.length);
        AllProductsController.listData=removeDuplicatesMiddleWare(AllProductsController.listData);
        print("length of data after removing duplicates ");
        print(AllProductsController.listData.length);
        if (reload) {
          emit(Reload());
          await Future.delayed(const Duration(milliseconds: 800));
          emit(AllShopsLoaded());
        } else {
          emit(AllShopsLoaded());
        }
        return true;
      } else {
        emit(AllShopsError());
        return false;
      }
    } else {
      return false;
    }
  }


  List<AllStoresDatum> removeDuplicatesMiddleWare(List<AllStoresDatum> inputList) {
    final Map<int, AllStoresDatum> uniqueMap = {};
    final Map<int, int> duplicateCountMap = {};
print("input list length");
print(inputList.length);
    for (var datum in inputList) {
      if (!uniqueMap.containsKey(datum.identifier)) {
        uniqueMap[datum.identifier] = datum;
      } else {
        duplicateCountMap[datum.identifier] =
            (duplicateCountMap[datum.identifier] ?? 0) + 1;
      }
    }

    duplicateCountMap.forEach((identifier, count) {
      print('Duplicate with identifier $identifier found $count times.');
    });
    print("output list length");
    print(uniqueMap.values.toList().length);
    return uniqueMap.values.toList();
  }
}
