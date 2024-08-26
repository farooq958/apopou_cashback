import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:cashback/controller/countryList/country_list_cubit.dart';
import 'package:cashback/view/custom_widgets/custom_button.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/splashScreen/splash_second.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../custom_widgets/app_color.dart';
import '../custom_widgets/country_drop_down.dart';
import 'package:cashback/view/imports.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var country;
  String _authStatus = 'Unknown';
  @override
  void initState() {
    Future.wait([
      context.read<CountryListCubit>().getCountryList(),
    ]).then((value) {
      print(value);
      country =0;
    });
    // NotificationConfig().notificationPayload(context);
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) => initPlugin());
    super.initState();
  }
  Future<void> initPlugin() async {
    final TrackingStatus status =
    await AppTrackingTransparency.trackingAuthorizationStatus;
    setState(() => _authStatus = '$status');
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
      setState(() => _authStatus = '$status');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  Future<void> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            'We care about your privacy and data security. We keep this app free by showing product. '
                'Can we continue to use your data to tailor product recommended for you?\n\nYou can change your choice anytime in the app settings. '
                'Our partners will collect data and use a unique identifier on your device to show you ads.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue'),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Stack(
            children: [
              Positioned(
                top: -300.sp,
                left: -220.sp,
                child: Container(
                  width: 720.0,
                  height: 467.0.sp,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(360.0, 233.5)),
                    color: Color(0xFFFC4F08),
                  ),
                ),
              ),
              Positioned(
                top: -290.sp,
                left: -200.sp,
                child: Container(
                  width: 720.0,
                  height: 467.0.sp,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(360.0, 233.5)),
                    color: Color(0xFFFC4F08).withOpacity(.3),
                  ),
                ),
              ),
              Positioned(
                top: -285.sp,
                left: -180.sp,
                child: Container(
                  width: 720.0,
                  height: 467.0.sp,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(const Radius.elliptical(360.0, 233.5)),
                    color: Color(0xFFFC4F08).withOpacity(.3),
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0.35.sh,
                  child: Image.asset(
                    "images/logo_orange.png",
                    height: 100.sp,
                  )),
              Positioned(
                left: 0,
                right: 0,
                top: 0.46.sh,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15.sp),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomText(
                      'Our Prioirty is to provide the\n best services that meets your expectation\n and this is the sample description'
                          .tr(),
                      style: Styles.robotoStyle(
                        FontWeight.w500,
                        17.0.sp,
                          const Color(0xFF363636),
                        context

                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30.sp,
                right: 0,
                top: 0.55.sh,
                child: CustomText(
                  'Select your country'.tr(),
                  style: Styles.robotoStyle(

                    FontWeight.w900,
                    16.0.sp,
                    Colors.black,
                    context,

                    letterSpacing: 0.192,

                  ),
                ),
              ),

              Positioned(
                left: 30.sp,
                right: 30.sp,
                top: 0.59.sh,
                child: BlocBuilder<CountryListCubit, CountryListState>(
                  builder: ((context, state) {
                    return ButtonTheme(
                      alignedDropdown: true,
                      child: CountryDropDownWidget(
                        hintText: "Select country".tr(),
                        value: country,
                        validationText: "Please select country",
                        onChanged: (v) {
                          setState(() {
                            country = v;
                          });
                        },
                        itemsMap: state.list.map((e) {
                          return DropdownMenuItem(
                            value: e.identifier,
                            child: Row(
                              children: [
                                Image.network(
                                  e.icon.toString(),
                                  width: 20.w,
                                  height: 30.h,
                                ),
                                SizedBox(width: 10.w),
                                CustomText(
                                  e.title.toString(),
                                  style: Styles.robotoStyle(
                                    FontWeight.normal,
                                    14.sp,
                                    AppColor.blackColor,context
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ),
              ),

              //   Container(
              //     width: 300.0.sp,
              //     height: 46.0.sp,
              //     child: DropdownSearch<String>(
              //       popupProps: PopupProps.menu(
              //         constraints: BoxConstraints(maxHeight: 110),
              //         showSelectedItems: true,
              //         disabledItemFn: (String s) => s.startsWith('I'),
              //       ),
              //       items: ["Greek".tr(), "Cyprus".tr()],
              //       onChanged: print,
              //       dropdownDecoratorProps: DropDownDecoratorProps(
              //         dropdownSearchDecoration: InputDecoration(
              //           contentPadding: EdgeInsets.only(left: 20.sp),
              //           enabledBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(12),
              //               borderSide:
              //                   const BorderSide(color: Color(0xffFFA07A))),
              //           hintText: "Cyprus".tr(),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Positioned(
                  top: 0.8.sh,
                  left: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashSecond()));
                      if (country != null) {
                        await prefs.setBool("initial", true);
                        await prefs.setString("country_id",
                            int.parse(country.toString()).toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashSecond()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              CustomText("Please select country, to continue".tr()),
                          duration: Duration(seconds: 1),
                        ));
                      }
                    },
                    child: CustomButton(
                      title: "ENTER".tr(),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
