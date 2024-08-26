import 'package:bloc/bloc.dart';
import 'package:cashback/controller/parent_categories_controller.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/parent_categories.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'services/apis.dart';
part 'parent_categories_state.dart';

class ParentCategoriesCubit extends Cubit<ParentCategoriesState> {
  ParentCategoriesCubit() : super(ParentCategoriesInitial());

  Future<void> parentCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    emit(ParentCategoriesLoading());
    var request = http.Request('GET',
        Uri.parse('${finalServer}/api/categories/parent?sort_by=sortNo'));
//?sort_by=sortNo
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      ParentCategoriesController.data = ParentCategories.fromRawJson(str);
      emit(ParentCategoriesLoaded());
    } else {
      print(response.reasonPhrase);
      emit(ParentCategoriesError());
    }
  }
}
