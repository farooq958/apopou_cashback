part of 'internet_checker_bloc.dart';

abstract class InternetCheckerState extends Equatable {
  const InternetCheckerState();

  @override
  List<Object> get props => [];
}

class InternetCheckerInitial extends InternetCheckerState {}

class InternetAvailable extends InternetCheckerState {}

class InternetNotAvailable extends InternetCheckerState {}
