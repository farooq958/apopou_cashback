import 'dart:developer';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/multiline_textField.dart';
import 'package:cashback/view/custom_widgets/payment_method_button.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/controller/withdrawCubit/withdraw_cubit.dart';
import 'package:cashback/view/withdraw/successfully_withdrawn.dart';
import 'package:cashback/view/custom_widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controller/services/currency_service.dart';
import '../../../controller/shared_preferences.dart';
import 'package:cashback/view/imports.dart';
class WithDrawScreen extends StatefulWidget {
  WithDrawScreen({super.key});

  @override
  State<WithDrawScreen> createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {
  bool isBankActive = false;
  bool isPaypalActive = false;
  final bankController = TextEditingController();
  final payPalController = TextEditingController();
  final amountController = TextEditingController();
  final bankFormKey = GlobalKey<FormState>();
  final payPalFormKey = GlobalKey<FormState>();
  String currency = "";
  String yearlyFee = "";
  Map<String, dynamic> responseMap = {};
  @override
  void initState() {
    currencyAndFeeGet();
    super.initState();
  }

  Future currencyAndFeeGet() async {
    var c = await CurrencyPrefs.getCurrency();
    Map<String, dynamic> map = await CurrencyService.getCurrency();
    var yearlyMaintenanceFee = map['data'][1]['setting_value'];
    setState(() {
      currency = c;
      yearlyFee = yearlyMaintenanceFee;
    });

    log("FEE $yearlyFee");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space(20),
                backButton(context),
                space(20),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.lightWhiteColor.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30).r,
                      topRight: Radius.circular(30).r,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      upperTextContainer(context),
                      space(20),
                      lowerPaymentMethodBody(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget lowerPaymentMethodBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleCustomText("Payment Method".tr()),
          space(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PaymentMethodButtonWidget(
                imageUrl: "images/bank.png",
                isActive: isBankActive,
                onTap: () {
                  setState(() {
                    isBankActive = true;
                    isPaypalActive = false;
                  });
                },
              ),
              PaymentMethodButtonWidget(
                imageUrl: "images/paypal.png",
                isActive: isPaypalActive,
                onTap: () {
                  setState(() {
                    isBankActive = false;
                    isPaypalActive = true;
                  });
                },
              ),
            ],
          ),
          space(30),
          isBankActive
              ? bankActiveWidget()
              : isPaypalActive
                  ? payPalActiveWidget()
                  : button(),
        ],
      ),
    );
  }

  InkWell button() {
    return InkWell(
        onTap: () async {
          if (isBankActive == false || isPaypalActive == false) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: CustomText("Please select one payment method".tr())));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SuccessfullyWithDrawnScreen())));
          }
        },
        child: CustomButton(title: "Confirm".tr()));
  }

  Widget bankActiveWidget() {
    return Form(
      key: bankFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleCustomText("Bank Details".tr()),
          space(10),
          subTitleCustomText("Please enter the following information:".tr()),
          subTitleCustomText("Your Name (Name / Surname)".tr()),
          subTitleCustomText("Bank Name".tr()),
          subTitleCustomText("IBAN Number".tr()),
          space(10),
          MultiLineTextField(
            controller: bankController,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return "Please provide bank details".tr();
              } else {
                return null;
              }
            },
          ),
          space(20),
          amountCustomText("Amount".tr()),
          space(10),
          AmountTextField(
            controller: amountController,
            currency: currency,
          ),
          space(30),
          BlocListener<WithdrawCubit, WithdrawState>(
            listener: (context, state) {
              // if (state.status == WithDrawStatus.error) {

              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: CustomText("An error occured, Please try again!."),
              //     duration: Duration(seconds: 1),
              //   ));
              // }

              // if (state.status == WithDrawStatus.success) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: ((context) => SuccessfullyWithDrawnScreen())));
              // }
            },
            child: BlocBuilder<WithdrawCubit, WithdrawState>(
              builder: (context, state) {
                if (state.status == WithDrawStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  );
                }
                return InkWell(
                  onTap: () async {
                    if (bankFormKey.currentState!.validate()) {
                      Map<String, dynamic> map = {
                        "payment_method": "bank",
                        "amount": amountController.text,
                        "details": bankController.text,
                      };
                      var data = await context
                          .read<WithdrawCubit>()
                          .WithDrawPayment(map);

                      if (data["min_payout"] is List ||
                          data["low_balance"] is List) {
                        ScaffoldMessenger.of(this.context)
                            .showSnackBar(SnackBar(
                          content: CustomText(
                              "${data['min_payout'] == null ? "" : data['min_payout'][0]} \n${data['low_balance'] == null ? "" : data['low_balance'][0]}"),
                          duration: Duration(seconds: 5),
                        ));
                      } else {
                        Navigator.push(
                            this.context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    SuccessfullyWithDrawnScreen())));
                      }
                    }
                  },
                  child: CustomButton(title: "Confirm".tr()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget payPalActiveWidget() {
    return Form(
      key: payPalFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleCustomText("PayPal Details".tr()),
          space(10),
          subTitleCustomText("Please enter your paypal account (Paypal Email)".tr()),
          space(10),
          MultiLineTextField(
            maxline: 1,
            controller: payPalController,
            textInputType: TextInputType.emailAddress,
            validator: (v) {
              Pattern pattern =
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
              RegExp regExp = RegExp(pattern.toString());
              if (v!.trim().isEmpty) {
                return "Please provide paypal email".tr();
              } else if (!regExp.hasMatch(v)) {
                return "Please provide valid email".tr();
              } else {
                return null;
              }
            },
          ),
          space(20),
          amountCustomText("Amount".tr()),
          space(10),
          AmountTextField(
            controller: amountController,
            currency: currency,
          ),
          space(30),
          BlocListener<WithdrawCubit, WithdrawState>(
            listener: (context, state) {
              // if (state.status == WithDrawStatus.error) {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: CustomText("An error occured, Please try again!."),
              //     duration: Duration(seconds: 1),
              //   ));
              // }

              // if (state.status == WithDrawStatus.success) {
              //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   //   content: CustomText(
              //   //       "Payment Successful\nWithdrawl request has been added"),
              //   //   duration: Duration(seconds: 1),
              //   // ));
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: ((context) => SuccessfullyWithDrawnScreen())));
              // }
            },
            child: BlocBuilder<WithdrawCubit, WithdrawState>(
              builder: (context, state) {
                if (state.status == WithDrawStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  );
                }
                return InkWell(
                  onTap: () async {
                    if (payPalFormKey.currentState!.validate()) {
                      Map<String, dynamic> map = {
                        "payment_method": "paypal",
                        "amount": amountController.text,
                        "details": payPalController.text,
                      };
                      var data = await context
                          .read<WithdrawCubit>()
                          .WithDrawPayment(map);

                      if (data["min_payout"] is List ||
                          data["low_balance"] is List) {
                        ScaffoldMessenger.of(this.context)
                            .showSnackBar(SnackBar(
                          content: CustomText(
                              "${data['min_payout'] == null ? "" : data['min_payout'][0]} \n${data['low_balance'] == null ? "" : data['low_balance'][0]}"),
                          duration: Duration(seconds: 5),
                        ));
                      } else {
                        Navigator.push(
                            this.context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    SuccessfullyWithDrawnScreen())));
                      }
                    }
                  },
                  child: CustomButton(title: "Confirm".tr()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  CustomText titleCustomText(String text) {
    return CustomText(
      text,
      style: Styles.robotoStyle(
        FontWeight.bold,
        20,
        AppColor.blackColor,
        context
      ),
    );
  }

  CustomText subTitleCustomText(String text) {
    return CustomText(
      text,
      style: Styles.robotoStyle(
        FontWeight.normal,
        15,
        AppColor.blackColor,
        context
      ),
    );
  }

  CustomText amountCustomText(String text) {
    return CustomText(
      text,
      style: Styles.robotoStyle(
        FontWeight.bold,
        15,
        AppColor.blackColor,
        context
      ),
    );
  }

  Widget upperTextContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13).r,
      height: MediaQuery.of(context).size.height * 0.135,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30).r,
          topRight: Radius.circular(30).r,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomText(
            "Withdraw Payment".tr(),
            style: Styles.robotoStyle(
              FontWeight.bold,
              27,
              AppColor.whiteColor,
              context
            ),
          ),
          space(6),
          RichText(
            textScaleFactor: 1.0,
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      "In the first undertaking of the year the amount of 5 € is withheld"
                          .tr(),
                  style: Styles.robotoStyle(
                    FontWeight.normal,
                    15,
                    AppColor.whiteColor,
                      context
                  ),
                ),
                TextSpan(
                  text: " ${currency} ",
                  style: Styles.robotoStyle(
                    FontWeight.normal,
                    15,
                    AppColor.whiteColor,
                      context
                  ),
                ),
                TextSpan(
                  text: yearlyFee,
                  style: Styles.robotoStyle(
                    FontWeight.normal,
                    15,
                    AppColor.whiteColor,
                    context
                  ),
                ),
              ],
            ),
          ),
          // CustomText(
          //   "In the first undertaking of the year the amount of 5 € is withheld"
          //       .tr(),
          //   textAlign: TextAlign.center,
          //   style: Styles.robotoStyle(
          //     FontWeight.normal,
          //     15,
          //     AppColor.whiteColor,
          //   ),
          // ),
          space(10),
        ],
      ),
    );
  }

  Widget backButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back,
        size: 32.r,
        color: Colors.black,
      ),
    );
  }

  Widget space(double height) {
    return SizedBox(
      height: height.h,
    );
  }
}

class AmountTextField extends StatelessWidget {
  final TextEditingController controller;
  final String currency;

  const AmountTextField({
    super.key,
    required this.controller,
    required this.currency,
  });
  final double borderRadius = 12.0;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v!.trim().isEmpty) {
          return "Please provide amount".tr();
        } else
          return null;
      },
      keyboardType: TextInputType.number,
      controller: controller,
      style:
          Styles.robotoStyle(FontWeight.normal, 15, AppColor.lightBlackColor,context),
      decoration: InputDecoration(
        hintText: "Enter amount here".tr(),
        prefixIcon: SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: CustomText(
              currency,
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,


              ),
            ),
          ),
        ),
        filled: true,
        fillColor: AppColor.MultiLineTextFieldColor,
        hintStyle:
            Styles.robotoStyle(FontWeight.normal, 15, AppColor.greyColor,context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: const BorderSide(color: AppColor.blackColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: const BorderSide(color: AppColor.greyColor),
        ),
      ),
    );
  }
}
