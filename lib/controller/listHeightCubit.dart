import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class ListHeightCubit extends Cubit<bool> {
  ListHeightCubit() : super(false);

  void setHeight(bool height) {
    log("setting height to $height");
    emit(height);
  }
}
