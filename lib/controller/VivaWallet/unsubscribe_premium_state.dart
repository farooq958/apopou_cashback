part of 'unsubscribe_premium_cubit.dart';

@immutable
abstract class UnsubscribePremiumState {}

class UnsubscribePremiumInitial extends UnsubscribePremiumState {}
class UnsubscribePremiumLoading extends UnsubscribePremiumState {}
class UnsubscribePremiumLoaded extends UnsubscribePremiumState {

  final UnsubscribeModel data;
  UnsubscribePremiumLoaded({required this.data});

}
class UnsubscribePremiumError extends UnsubscribePremiumState {}
