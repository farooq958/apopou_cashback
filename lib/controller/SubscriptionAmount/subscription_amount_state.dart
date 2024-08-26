part of 'subscription_amount_cubit.dart';

@immutable
abstract class SubscriptionAmountState {}

class SubscriptionAmountInitial extends SubscriptionAmountState {}

class SubscriptionAmountLoaded extends SubscriptionAmountState {



}
class SubscriptionAmountInternetError extends SubscriptionAmountState {}
class SubscriptionAmountUnknownError extends SubscriptionAmountState {}
