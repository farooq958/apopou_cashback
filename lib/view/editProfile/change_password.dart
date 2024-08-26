import 'dart:developer';
import 'package:cashback/controller/services/change_password.dart';
import 'package:cashback/controller/changePasswordCubit/change_password_cubit.dart';
import 'package:cashback/view/editProfile/successfully_password_changed.dart';
import 'package:cashback/view/custom_widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/imports.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textAndBack(context),
              space(10),
              body(),
              space(30),
            ],
          ),
        ),
      )),
    );
  }

  Widget body() {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30).r,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(8).r,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleCustomText("Enter Your Current Password".tr()),
            TextFieldWidget(
                controller: currentPasswordController,
                hintText: "Enter Your Current Password".tr(),
                prefixIcon: Icon(Icons.lock_outline_rounded,
                    color: AppColor.lightBlackColor),
                obscureText: true,
                textInputType: TextInputType.text,
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return "Please provide current password".tr();
                  } else {
                    return null;
                  }
                }),
            space(30),
            Padding(
              padding: const EdgeInsets.only(left: 5).r,
              child: CustomText(
                "New Password".tr(),
                style: Styles.robotoStyle(
                  FontWeight.bold,
                  26,
                  AppColor.blackColor,context
                ),
              ),
            ),
            space(30),
            titleCustomText("New Password".tr()),
            TextFieldWidget(
                controller: newPasswordController,
                hintText: "New Password".tr(),
                prefixIcon: Icon(Icons.lock_open_outlined,
                    color: AppColor.lightBlackColor),
                obscureText: true,
                textInputType: TextInputType.text,
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return "Please provide new password".tr();
                  } else if (v.length < 8) {
                    return "Password Length should be greater than 7".tr();
                  } else {
                    return null;
                  }
                }),
            space(15),
            titleCustomText("Confirm New Password".tr()),
            TextFieldWidget(
                controller: confirmNewPasswordController,
                hintText: "Confirm New Password".tr(),
                prefixIcon: Icon(Icons.lock_outline_rounded,
                    color: AppColor.lightBlackColor),
                obscureText: true,
                textInputType: TextInputType.text,
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return "Please provide new password".tr();
                  } else if (v != newPasswordController.text) {
                    return "Password not matched".tr();
                  } else {
                    return null;
                  }
                }),
            space(100),
            BlocListener<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                // if (state.status == ChangePasswordStatus.error) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: CustomText("Current Password is wrong."),
                //     duration: Duration(seconds: 1),
                //   ));
                // }
                // if (state.status == ChangePasswordStatus.success) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: CustomText("Password Changed successfully."),
                //     duration: Duration(milliseconds: 500),
                //   ));
                //   // Navigator.pushReplacement(
                //   //     context,
                //   //     MaterialPageRoute(
                //   //         builder: (context) =>
                //   //             SuccessfullyPasswordChangeScreen()));
                // }
              },
              child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                builder: (context, state) {
                  if (state.status == ChangePasswordStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        var res = await context
                            .read<ChangePasswordCubit>()
                            .ChangePassword(
                              currentPasswordController.text,
                              confirmNewPasswordController.text,
                            );

                        if (res == true) {
                          ScaffoldMessenger.of(this.context)
                              .showSnackBar(SnackBar(
                            content: CustomText("Password Changed successfully".tr()),
                            duration: Duration(milliseconds: 500),
                          ));
                          Navigator.pushReplacement(
                              this.context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SuccessfullyPasswordChangeScreen()));
                        } else {
                          ScaffoldMessenger.of(this.context)
                              .showSnackBar(SnackBar(
                            content: CustomText("Current Password is wrong".tr()),
                            duration: Duration(seconds: 1),
                          ));
                        }
                      }
                    },
                    child: CustomButton(title: "Save".tr()),
                  );
                },
              ),
            ),
            space(10),
          ],
        ),
      ),
    );
  }

  Widget titleCustomText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10).r,
      child: CustomText(
        text,
        style: Styles.robotoStyle(
          FontWeight.bold,
          18,
          AppColor.blackColor,context
        ),
      ),
    );
  }

  Widget textAndBack(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        space(20),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 32.r,
            color: Colors.black,
          ),
        ),
        space(10),
        CustomText(
          "Change Password".tr(),
          style: Styles.robotoStyle(
            FontWeight.bold,
            25.sp,
            AppColor.blackColor,context
          ),
        ),
        space(15),
      ],
    );
  }

  Widget space(double height) {
    return SizedBox(
      height: height.h,
    );
  }
}
