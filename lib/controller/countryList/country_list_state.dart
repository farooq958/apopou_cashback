// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'country_list_cubit.dart';

enum CountryListStatus {
  initial,
  loading,
  success,
  error,
}

class CountryListState extends Equatable {
  final CountryListStatus status;
  final List<CountryListModel> list;
  CountryListState({
    required this.status,
    required this.list,
  });

  factory CountryListState.initial() {
    return CountryListState(status: CountryListStatus.initial, list: []);
  }

  @override
  List<Object?> get props => [status, list];

  CountryListState copyWith({
    CountryListStatus? status,
    List<CountryListModel>? list,
  }) {
    return CountryListState(
      status: status ?? this.status,
      list: list ?? this.list,
    );
  }
}
