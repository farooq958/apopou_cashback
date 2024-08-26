import 'dart:developer';
import 'dart:io';
import 'package:cashback/view/imports.dart';
import 'package:cashback/controller/countryList/country_list_cubit.dart';
import 'package:cashback/controller/deActivateCubit/de_activate_cubit.dart';
import 'package:cashback/controller/services/logout_service.dart';
import 'package:cashback/controller/editProfileCubit/edit_profile_cubit.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/custom_bottom_sheet.dart';
import 'package:cashback/view/custom_widgets/custom_button.dart';
import 'package:cashback/view/custom_widgets/custom_text_field.dart';
import 'package:cashback/view/custom_widgets/image_picker.dart';
import 'package:cashback/view/editProfile/change_password.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/user/cubit/user_cubit.dart';
import '../../../model/user_model.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel model;
  const EditProfileScreen({
    super.key,
    required this.model,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  // final lastNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;
  // var country;

  getUserInfo() async {
    nameController.text = widget.model.userName.toString();
    firstNameController.text = widget.model.firstName.toString();
    // lastNameController.text = widget.model.lastName.toString();
    emailController.text = widget.model.contactEmail.toString();
  }

  @override
  void initState() {
    getUserInfo();
    // Future.wait([
    //   context.read<CountryListCubit>().getCountryList(),
    // ]);
    // country = widget.model.country == "0"
    //     ? country
    //     : int.parse(widget.model.country!);
    super.initState();
  }

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
        ),
      ),
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
            titleCustomText(text: "username".tr(), color: AppColor.primaryColor),
            AbsorbPointer(
              child: TextFieldWidget(
                borderColor: AppColor.primaryColor,
                textColor: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                textSize: 16,
                controller: nameController,
                hintText: "Enter user name",
                prefixIcon: Icon(Icons.person, color: AppColor.primaryColor),
                obscureText: false,
                textInputType: TextInputType.text,
                validator: (v) => null,
              ),
            ),
            space(15),
            titleCustomText(text: "First Name"),
            TextFieldWidget(
              controller: firstNameController,
              hintText: "fname",
              prefixIcon:
                  Icon(Icons.person_outline, color: AppColor.lightBlackColor),
              obscureText: false,
              textInputType: TextInputType.text,
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return "Please provide first name";
                } else {
                  return null;
                }
              },
            ),
            //space(15),
            // titleCustomText("Last Name"),
            // TextFieldWidget(
            //   controller: lastNameController,
            //   hintText: "Enter last name",
            //   prefixIcon:
            //       Icon(Icons.person_outline, color: AppColor.lightBlackColor),
            //   obscureText: false,
            //   textInputType: TextInputType.text,
            //   validator: (v) {
            //     if (v!.trim().isEmpty) {
            //       return "Please provide last name";
            //     } else {
            //       return null;
            //     }
            //   },
            // ),
            space(15),
            titleCustomText(text: "Contact Email"),
            TextFieldWidget(
              controller: emailController,
              hintText: "contact-email",
              prefixIcon: Icon(Icons.email, color: AppColor.lightBlackColor),
              obscureText: false,
              textInputType: TextInputType.emailAddress,
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return "Please provide email";
                } else {
                  return null;
                }
              },
            ),
            // space(15),
            // titleCustomText("Country"),
            // BlocBuilder<CountryListCubit, CountryListState>(
            //   builder: ((context, state) {
            //     return CustomDropDownWidget(
            //       hintText: "Select country",
            //       value: country,
            //       validationText: "Please select sountry",
            //       onChanged: (v) {
            //         setState(() {
            //           country = v;
            //         });
            //       },
            //       itemsMap: state.list.map((e) {
            //         return DropdownMenuItem(
            //           value: e.identifier,
            //           child: Row(
            //             children: [
            //               Image.network(
            //                 e.icon.toString(),
            //                 width: 20.w,
            //                 height: 30.h,
            //               ),
            //               SizedBox(width: 10.w),
            //               CustomText(
            //                 e.title.toString(),
            //                 style: Styles.robotoStyle(
            //                   FontWeight.normal,
            //                   14.sp,
            //                   AppColor.blackColor,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       }).toList(),
            //     );
            //   }),
            // ),
            space(30),
            listTileWidget(
                name: "Change Password",
                icon: Icons.lock,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen()))),
            space(15),
            listTileWidget(
              name: "Deactivate your account",
              icon: Icons.person,
              onTap: () => deactivateDialog(),
            ),

            space(50),
            BlocListener<EditProfileCubit, EditProfileState>(
              listener: (context, state) {
                if (state.status == EditProfileStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: CustomText(
                        "You need to specify a different value to update".tr()),
                    duration: Duration(seconds: 1),
                  ));
                }
                if (state.status == EditProfileStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: CustomText("Profile updated successfully".tr()),
                    duration: Duration(milliseconds: 500),
                  ));

                  Navigator.of(context).pop();
                  context.read<UserCubit>().getUser();
                }
              },
              child: BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  if (state.status == EditProfileStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await context.read<EditProfileCubit>().editProfile(
                              widget.model.identifier!,
                              emailController.text,
                              firstNameController.text,
                              //lastNameController.text,
                              // "hi",
                              // country.toString(),
                            );
                      }
                    },
                    child: CustomButton(title: "Save Changes".tr()),
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

  Widget listTileWidget({
    required String name,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13).r,
        decoration: BoxDecoration(
            color: AppColor.greyColor2,
            borderRadius: BorderRadius.circular(13).r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColor.primaryColor,
                ),
                SizedBox(width: 10.w),
                CustomText(
                  name.tr(),
                  style: Styles.robotoStyle(
                    FontWeight.bold,
                    15,
                    AppColor.blackColor,context
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.lightBlackColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget imageContainer() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        image != null
            ? Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primaryColor),
                    image: DecorationImage(
                        image: FileImage(image!), fit: BoxFit.fill)),
              )
            : Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primaryColor)),
                child: Image.asset(
                  'images/man.png',
                  fit: BoxFit.contain,
                ),
              ),
        Positioned(
          bottom: 5,
          right: 1,
          child: GestureDetector(
            onTap: () => bottomSheet(
              context: context,
              onCameraTap: () async {
                log("camera");
                Navigator.of(context).pop();
                var imagePath =
                    await CustomImagePicker.getImage(ImageSource.camera);
                setState(() {
                  image = imagePath;
                });
              },
              onGalleryTap: () async {
                Navigator.of(context).pop();
                var imagePath =
                    await CustomImagePicker.getImage(ImageSource.gallery);
                setState(() {
                  image = imagePath;
                });
              },
            ),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.edit,
                  color: AppColor.whiteColor,
                  size: 18.r,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget titleCustomText({required String text, Color? color = AppColor.blackColor}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10).r,
      child: CustomText(
        text.tr(),
        style: Styles.robotoStyle(
          FontWeight.bold,
          18,
          color!,context
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
          "Edit Profile".tr(),
          style: Styles.robotoStyle(
            FontWeight.bold,
            24,
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

  Future<void> deactivateDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              space(30),
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    "images/deactivate.png",
                    width: 70.w,
                    height: 70.h,
                  ),
                ),
              ),
              space(25),
              CustomText(
                "Do you want to \n deactivate  your account".tr(),
                textAlign: TextAlign.center,
                style: Styles.robotoStyle(
                  FontWeight.bold,
                  20,
                  AppColor.lightBlackColor,context
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 5).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.greyColor,
                      minimumSize: Size(90, 40),
                    ),
                    child: CustomText(
                      'Cancel'.tr(),
                      style: Styles.robotoStyle(
                        FontWeight.bold,
                        13.sp,
                        AppColor.whiteColor,context
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  BlocBuilder<DeActivateCubit, DeActivateState>(
                    builder: (context, state) {
                      if (state.status == DeactivateStatus.loading) {
                        return SizedBox(
                          width: 90.w,
                          height: 40.h,
                          child: Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primaryColor),
                          ),
                        );
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          minimumSize: Size(110, 42),
                        ),
                        child: CustomText(
                          "Deactivate".tr(),
                          style: Styles.robotoStyle(
                            FontWeight.bold,
                            13.sp,
                            AppColor.whiteColor,context
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await context
                              .read<DeActivateCubit>()
                              .deActivateUser(widget.model.userName.toString());
                          await LogoutService.logoutUser();
                          await prefs.remove("token");
                          await prefs.remove("uid");
                          await prefs.remove("initial");
                          Navigator.of(context).pop();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen()),
                              (Route<dynamic> route) => false);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
