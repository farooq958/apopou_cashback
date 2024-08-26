
import 'package:cashback/controller/VivaWallet/loadingweb_cubit.dart';
import 'package:cashback/controller/VivaWallet/unsubscribe_premium_cubit.dart';
import 'package:cashback/controller/VivaWallet/wallet_url_cubit.dart';
import 'package:cashback/controller/internetChecker/internet_checker_bloc.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/addtofavouritepremium_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/remove_favourite_premium_coupon_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumUser/premium_user_cubit.dart';
import 'package:cashback/controller/premiumControllers/hiddenattribute/hidden_attribute_cubit.dart';
import 'package:cashback/controller/premiumControllers/premium_favourite_cubit.dart';
import 'package:cashback/controller/services/dialog_show_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/SubscriptionAmount/subscription_amount_cubit.dart';
import '../controller/bottom_navigation_page_index_cubit.dart';
import '../controller/product_types_page_index_cubit.dart';
import '../controller/repository/marketplace_Repo.dart';
import '../controller/searchHeightCubit.dart';
import 'package:cashback/controller/LoginCubit/login_cubit.dart';
import 'package:cashback/controller/add_to_fav_cubit.dart';
import 'package:cashback/controller/all_favourite_products_cubit.dart';
import 'package:cashback/controller/all_feature_shops_cubit.dart';
import 'package:cashback/controller/all_shops_cubit.dart';
import 'package:cashback/controller/categories_cubit.dart';
import 'package:cashback/controller/categoryCubit/ParentCategory/parent_category_cubit.dart';
import 'package:cashback/controller/categoryCubit/subCategoryCubit/sub_category_cubit_cubit.dart';
import 'package:cashback/controller/countryList/country_list_cubit.dart';
import 'package:cashback/controller/deActivateCubit/de_activate_cubit.dart';
import 'package:cashback/controller/listHeightCubit.dart';
import 'package:cashback/controller/logout_cubit.dart';
import 'package:cashback/controller/market_place/marketplacebloc/marketplace_cubit.dart';
import 'package:cashback/controller/notificationsCubit/deleteOneNotificationCubit/delete_one_notification_cubit.dart';
import 'package:cashback/controller/notificationsCubit/notificationCubit/notification_cubit.dart';
import 'package:cashback/controller/parent_categories_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/all_coupon_premium_cubit.dart';
import 'package:cashback/controller/premiumControllers/Services/coupon_service.dart';
import 'package:cashback/controller/premiumControllers/Services/parent_catergory_service.dart';
import 'package:cashback/controller/premiumControllers/couponCubit/coupon_cubit.dart';
import 'package:cashback/controller/premiumControllers/parentCategoryCubit/premium_parent_category_cubit.dart';
import 'package:cashback/controller/remove_fav_cubit.dart';
import 'package:cashback/controller/repository/category_repo.dart';
import 'package:cashback/controller/repository/country_list_repo.dart';
import 'package:cashback/controller/repository/notifications_repo.dart';
import 'package:cashback/controller/repository/retailerRepo.dart';
import 'package:cashback/controller/retailerCubit/getCouponCubit/get_coupon_cubit.dart';
import 'package:cashback/controller/retailerCubit/sinlgeRetailerCubit/single_retailer_cubit.dart';
import 'package:cashback/controller/retailers_search_cubit/retailers_search_cubit.dart';
import 'package:cashback/controller/searchHeightCubit.dart';
import 'package:cashback/controller/services/Balance/balance_service.dart';
import 'package:cashback/controller/services/Balance/click_history_service.dart';
import 'package:cashback/controller/services/Balance/transaction_history_service.dart';
import 'package:cashback/controller/services/category_services.dart';
import 'package:cashback/controller/services/change_password.dart';
import 'package:cashback/controller/services/country_list_service.dart';
import 'package:cashback/controller/services/de_activate_account_service.dart';
import 'package:cashback/controller/services/edit_profile.dart';
import 'package:cashback/controller/services/notification_services.dart';
import 'package:cashback/controller/services/retailerServices.dart';
import 'package:cashback/controller/services/service_marketplace.dart';
import 'package:cashback/controller/services/user_referral_service.dart';
import 'package:cashback/controller/services/user_referrals_badges_service.dart';
import 'package:cashback/controller/services/withdraw_service.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/signup_cubit.dart';
import 'package:cashback/controller/subFavCubit/cubit/subfav_cubit.dart';
import 'package:cashback/controller/user/cubit/user_cubit.dart';
import 'package:cashback/controller/changePasswordCubit/change_password_cubit.dart';
import 'package:cashback/controller/editProfileCubit/edit_profile_cubit.dart';
import 'package:cashback/controller/clickHistoryCubit/click_history_cubit.dart';
import 'package:cashback/controller/balanceCubit/balance_cubit.dart';
import 'package:cashback/controller/transactionHistory/transaction_history_cubit.dart';
import 'package:cashback/controller/myReferralsCubit/my_referrals_cubit.dart';
import 'package:cashback/controller/myReferralsCubit/referral_badges_cubit.dart';
import 'package:cashback/controller/withdrawCubit/withdraw_cubit.dart';
import 'package:cashback/view/app_main_provider.dart';
import 'package:cashback/view/bottom_navigation_screen.dart';
import 'package:cashback/view/custom_widgets/internet_status_checker.dart';
import 'package:cashback/view/splashScreen/splash_second.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controller/services/user_service.dart';

final List<BlocProvider> mainCubitProvidersList=[

  BlocProvider<InternetCheckerBloc>(
      create: (BuildContext context) => InternetCheckerBloc()),
  BlocProvider<SearchHeightCubit>(
      create: (BuildContext context) => SearchHeightCubit()),
  BlocProvider<GetCouponCubit>(
      create: (BuildContext context) => GetCouponCubit(
          retailerRepo: context.read<RetailerRepo>())),
  BlocProvider<SingleRetailerCubit>(
      create: (BuildContext context) => SingleRetailerCubit(
          retailerRepo: context.read<RetailerRepo>())),
  BlocProvider<DeleteOneNotificationCubit>(
      create: (BuildContext context) =>
          DeleteOneNotificationCubit(
              notificationRepo:
              context.read<NotificationRepo>())),
  BlocProvider<NotificationCubit>(
      create: (BuildContext context) => NotificationCubit(
          notificationRepo: context.read<NotificationRepo>())),
  BlocProvider<SubCategoryCubit>(
      create: (BuildContext context) => SubCategoryCubit(
          categoryRepo: context.read<CategoryRepo>())),
  BlocProvider<ParentCategoryCubit>(
      create: (BuildContext context) => ParentCategoryCubit(
          categoryRepo: context.read<CategoryRepo>())),
  BlocProvider<BottomNavigationPageIndexCubit>(
    create: (BuildContext context) =>
        BottomNavigationPageIndexCubit(0),
  ),
  BlocProvider<ProductTypesPageIndexCubit>(
    create: (BuildContext context) =>
        ProductTypesPageIndexCubit(0),
  ),
  BlocProvider<SignupCubit>(
    create: (BuildContext context) => SignupCubit(),
  ),
  BlocProvider<AllShopsCubit>(
    create: (BuildContext context) => AllShopsCubit(),
  ),
  BlocProvider<AllFeatureShopsCubit>(
    create: (BuildContext context) => AllFeatureShopsCubit(),
  ),
  BlocProvider<LoginCubit>(
    create: (BuildContext context) => LoginCubit(),
  ),
  BlocProvider<CategoriesCubit>(
    create: (BuildContext context) => CategoriesCubit(),
  ),
  BlocProvider<AllFavouriteProductsCubit>(
    create: (BuildContext context) => AllFavouriteProductsCubit(),
  ),
  BlocProvider<ParentCategoriesCubit>(
    create: (BuildContext context) => ParentCategoriesCubit(),
  ),
  BlocProvider<LogoutCubit>(
    create: (BuildContext context) => LogoutCubit(),
  ),
  BlocProvider<AddToFavCubit>(
    create: (BuildContext context) => AddToFavCubit(),
  ),
  BlocProvider<SubfavCubit>(
    create: (BuildContext context) => SubfavCubit(),
  ),
  BlocProvider<RemoveFavCubit>(
    create: (BuildContext context) => RemoveFavCubit(),
  ),
  BlocProvider<RetailersSearchCubit>(
    create: (BuildContext context) => RetailersSearchCubit(),
  ),
  BlocProvider<ListHeightCubit>(
    create: (BuildContext context) => ListHeightCubit(),
  ),
  BlocProvider<MarketplaceCubit>(
      create: (context) => MarketplaceCubit(
          marketPlaceCategoryResposity:
          context.read<MarketPlaceCategoryResposity>())),
  BlocProvider<CountryListCubit>(
      create: (context) => CountryListCubit(
          repo: context.read<CountryListRepo>())),
  BlocProvider<UserCubit>(
      create: (context) => UserCubit(service: UserService())),
  BlocProvider<EditProfileCubit>(
      create: (context) =>
          EditProfileCubit(profileService: EditProfileService())),
  BlocProvider<DeActivateCubit>(
      create: (context) =>
          DeActivateCubit(service: DeActivateService())),
  BlocProvider<ChangePasswordCubit>(
      create: (context) =>
          ChangePasswordCubit(service: ChangePasswordService())),
  BlocProvider<BalanceCubit>(
      create: (context) =>
          BalanceCubit(service: BalanceService())),
  BlocProvider<TransactionHistoryCubit>(
      create: (context) => TransactionHistoryCubit(
          service: TransactionHistoryService())),
  BlocProvider<ClickHistoryCubit>(
      create: (context) =>
          ClickHistoryCubit(service: ClickHistoryService())),
  BlocProvider<WithdrawCubit>(
      create: (context) =>
          WithdrawCubit(service: WithDrawService())),
  BlocProvider<MyReferralsCubit>(
      create: (context) =>
          MyReferralsCubit(service: UserReferralService())),
  BlocProvider<ReferralBadgesCubit>(
      create: (context) => ReferralBadgesCubit(
          service: UserReferralBadgesService())),
  BlocProvider<PremiumParentCategoryCubit>(
      create: (context) => PremiumParentCategoryCubit(
          service: PremiumParentCategoryService())),
  // BlocProvider<CouponCubit>(
  //     create: (context) =>
  //         CouponCubit(service: PremiumCouponService())
  //
  // ),
  BlocProvider<AllCouponPremiumCubit>(create: (context)=>AllCouponPremiumCubit()),
  BlocProvider<PremiumFavouriteCubit>(create: (context)=>PremiumFavouriteCubit()),
  BlocProvider<AddToFavouritePremiumCubit>(create: (context)=>AddToFavouritePremiumCubit()),
  BlocProvider<RemoveFavouritePremiumCouponCubit>(create: (context)=>RemoveFavouritePremiumCouponCubit()),

  BlocProvider<WalletUrlCubit>(create: (context)=>WalletUrlCubit()),
  BlocProvider<SubscriptionAmountCubit>(create: (context)=>SubscriptionAmountCubit()),
  BlocProvider<UnsubscribePremiumCubit>(create: (context)=>UnsubscribePremiumCubit()),
  BlocProvider<DialogShowCubit>(create: (context)=>DialogShowCubit())
  ,
  BlocProvider<HiddenAttributeCubit>(create: (context)=>HiddenAttributeCubit()),
BlocProvider<LoadingWebCubit>(create: (context)=>LoadingWebCubit()),
  BlocProvider<PremiumUserCubit>(create: (context)=>PremiumUserCubit())

];