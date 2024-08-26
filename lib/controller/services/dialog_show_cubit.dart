

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';



class DialogShowCubit extends Cubit<bool> {
  DialogShowCubit() : super(false);

  showHideDialog(bool sh)
  {
    emit(false);
    Future.delayed(Duration(milliseconds: 16));
    emit(sh);
  }
}
