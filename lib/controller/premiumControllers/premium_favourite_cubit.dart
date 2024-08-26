import 'package:bloc/bloc.dart';


class PremiumFavouriteCubit extends Cubit<List<Map<dynamic,bool>>> {
  PremiumFavouriteCubit() : super([]);
  changeFav(value)
  {

    emit(value);

  }

}
