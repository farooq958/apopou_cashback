// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cashback/controller/services/country_list_service.dart';

import '../../model/countries_model.dart';

class CountryListRepo {
  final CountryListService service;
  CountryListRepo({
    required this.service,
  });

  Future<List<CountryListModel>> getCountryList() async {
    try {
      var res = await service.getCountryList();
      return res;
    } catch (e) {
      return [];
    }
  }
}
