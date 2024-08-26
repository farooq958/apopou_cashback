import 'package:flutter_bloc/flutter_bloc.dart';

class SearchHeightCubit extends Cubit<bool> {
  SearchHeightCubit() : super(false);

  void setHeight(bool height) {
    emit(height);
  }
}
