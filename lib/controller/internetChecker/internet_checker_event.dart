part of 'internet_checker_bloc.dart';

abstract class InternetCheckerEvent extends Equatable {
  const InternetCheckerEvent();
}

class InternetAvailableEvent extends InternetCheckerEvent {
  InternetAvailableEvent();

  @override
  List<Object?> get props => [];
}
