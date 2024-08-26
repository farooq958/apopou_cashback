import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class BottomNavigationPageIndexCubit extends Cubit<int> {
  BottomNavigationPageIndexCubit(super.initialState);
  setPageIndex({required index}){
    emit(index);
  }

}
