import 'package:bloc/bloc.dart';
import 'package:cashback/model/countries_model.dart';
import 'package:equatable/equatable.dart';
import '../repository/country_list_repo.dart';
part 'country_list_state.dart';

class CountryListCubit extends Cubit<CountryListState> {
  final CountryListRepo repo;
  CountryListCubit({
    required this.repo,
  }) : super(CountryListState.initial());

  Future<List<CountryListModel>> getCountryList() async {
    emit(state.copyWith(status: CountryListStatus.loading, list: []));
    try {
      var res = await repo.getCountryList();
      emit(state.copyWith(status: CountryListStatus.success, list: res));
      return res;
    } catch (e) {
      emit(state.copyWith(status: CountryListStatus.error, list: []));
      return [];
    }
  }
}
