part of 'all_coupon_premium_cubit.dart';

@immutable
abstract class AllCouponPremiumState {}

class AllCouponPremiumInitial extends AllCouponPremiumState {}
class AllCouponPremiumLoading extends AllCouponPremiumState {}
class AllCouponPremiumLoaded extends AllCouponPremiumState {



}
class AllCouponPremiumInternetError extends AllCouponPremiumState {}
class AllCouponPremiumUnknownError extends AllCouponPremiumState {}

