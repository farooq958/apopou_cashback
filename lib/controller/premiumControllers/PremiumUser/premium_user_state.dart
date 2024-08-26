part of 'premium_user_cubit.dart';

@immutable
abstract class PremiumUserState {}

class PremiumUserInitial extends PremiumUserState {}
class PremiumUserSuccess extends PremiumUserState {
final  PremiumUserModel premiumData;
  PremiumUserSuccess({required this.premiumData});

}
class PremiumUserLoading extends PremiumUserState {}
class PremiumUserError extends PremiumUserState {}


