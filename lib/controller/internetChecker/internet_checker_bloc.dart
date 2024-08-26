import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_checker_event.dart';
part 'internet_checker_state.dart';

class InternetCheckerBloc
    extends Bloc<InternetCheckerEvent, InternetCheckerState> {
  InternetCheckerBloc() : super(InternetCheckerInitial()) {
    on<InternetAvailableEvent>((event, emit) async {
      try {
        bool result = await InternetConnectionChecker().hasConnection;
        if (result == true) {
          emit(InternetAvailable());
        } else {
          emit(InternetNotAvailable());
        }
      } catch (e) {
        emit(InternetNotAvailable());
      }
    });
  }
}
