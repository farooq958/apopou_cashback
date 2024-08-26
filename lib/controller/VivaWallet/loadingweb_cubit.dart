import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';



class LoadingWebCubit extends Cubit<bool> {
  LoadingWebCubit() : super(true);

loadingWeb(bool load)
{
 // emit(true);
  emit(load);
}
}
