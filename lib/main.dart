import 'dart:developer';

import 'package:cashback/controller/repository/category_repo.dart';
import 'package:cashback/controller/repository/country_list_repo.dart';
import 'package:cashback/controller/repository/notifications_repo.dart';
import 'package:cashback/controller/repository/retailerRepo.dart';
import 'package:cashback/controller/services/category_services.dart';
import 'package:cashback/controller/services/country_list_service.dart';
import 'package:cashback/controller/services/notification_services.dart';
import 'package:cashback/controller/services/retailerServices.dart';
import 'package:cashback/controller/services/service_marketplace.dart';
import 'package:cashback/controller/shared_preferences.dart';
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
import 'controller/repository/marketplace_Repo.dart';
import 'view/splashScreen/splash_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("_messaging onBackgroundMessage: ${message.notification!.title!} ${message.notification!.body!}");
  return;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await PushNotificationServices().initNotification();
  // NotificationConfig().messagingInitiation();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();
  print(
      "MESSAGE ${message?.notification?.title} ${message?.notification?.body}");
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharePrefs.activateHomeTabController();
  await SharePrefs.init();
  MyConnectivity connectivity = MyConnectivity.instance;
  connectivity.initialise();

  runApp(EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('el', 'GR'),
      ],
      path: 'assets/translation',
      saveLocale: true,
      startLocale: Locale('el', 'GR'),
      // -- change the path of the translation files
      child: MyApp(remoteMessage: message)));
}

class MyApp extends StatelessWidget {
  final RemoteMessage? remoteMessage;

  MyApp({Key? key, required this.remoteMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,

        builder: (context, child) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<RetailerRepo>(
                  create: (context) =>
                      RetailerRepo(retailerServices: RetailerServices())),
              RepositoryProvider<NotificationRepo>(
                  create: (context) => NotificationRepo(
                      notificationServices: NotificationServices())),
              RepositoryProvider<CategoryRepo>(
                  create: (context) =>
                      CategoryRepo(categoryServices: CategoryServices())),
              RepositoryProvider(
                  create: (context) => MarketPlaceCategoryResposity(
                      allProductCategoryService: MarketPlaceService())),
              RepositoryProvider(
                  create: (context) =>
                      CountryListRepo(service: CountryListService())),
            ],
            child: MultiBlocProvider(
              providers:mainCubitProvidersList,
              child: MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: 'Apopou',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme:
                      Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                ),
                home: MediaQuery(data:  MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!),
              ),
            ),
          );
        },
        child: SharePrefs.prefs!.getString("token") == null
            ? SharePrefs.prefs!.getBool("initial") == null
                ? const SplashScreen()
                : SplashSecond()
            : BottomNavigationScreen(guest: false, remoteMessage: remoteMessage, isPremium: false,)
        // child: SharePrefs.prefs!.getString("token")==null?SharePrefs.prefs!.getBool("initial")==null?const SplashScreen():SplashSecond(): SplashSecond()
        //  child: const BottomNavigationScreen()
        );
  }
}
