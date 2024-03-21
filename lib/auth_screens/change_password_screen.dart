import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/components/custom_dialog.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/change_password_controller.dart';
import 'package:lawyerapp/controllers/login_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatelessWidget {
  String email;
  ChangePasswordScreen({super.key, required this.email});
  final LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ChangePasswordController controller =
      Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Center(
                          child: Image.asset(
                        'assets/images/lawyerapp-logo.png',
                        scale: 3,
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                    //   child: Center(
                    //     child: Text(
                    //       'LawyerConnect',
                    //       style: TextStyle(
                    //         fontSize: 20.sp,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.create_new_password,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.new_password_different,
                          style: TextStyle(fontSize: 14.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Obx(() => MyTextField(
                        controller: controller.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.password_empty;
                          }
                          if (value.length < 8) {
                            return AppLocalizations.of(context)!
                                .password_length;
                          }
                          // Add additional password strength checks as needed
                          // For example, you can check for the presence of uppercase letters, lowercase letters, numbers, and special characters

                          // Example: Check for lowercase letters
                          final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
                          if (!hasLowercase) {
                            return AppLocalizations.of(context)!
                                .lowercase_letters;
                          }

                          // Example: Check for uppercase letters
                          final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
                          if (!hasUppercase) {
                            return AppLocalizations.of(context)!
                                .uppercase_letters;
                          }

                          // Example: Check for numbers
                          final hasNumber = RegExp(r'[0-9]').hasMatch(value);
                          if (!hasNumber) {
                            return AppLocalizations.of(context)!.numbers;
                          }

                          // Example: Check for special characters
                          final hasSpecialCharacters =
                              RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
                          if (!hasSpecialCharacters) {
                            return AppLocalizations.of(context)!
                                .special_characters;
                          }
                          // if (controller.passwordController.value !=
                          //     controller.confirmPasswordController.value) {
                          //   return AppLocalizations.of(context)!.password_match;
                          // }
                          // Password meets all criteria, so return null indicating validation passed
                          return null;
                        },
                        isicon2: true,
                        onPressed: () {
                          loginController.passToggle.value =
                              !loginController.passToggle.value;
                        },
                        icon2: loginController.passToggle.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        hinttext: AppLocalizations.of(context)!.password,
                        icon: Icons.lock_outline)),
                    Obx(() => MyTextField(
                        controller: controller.confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.password_empty;
                          }
                          if (value.length < 8) {
                            return AppLocalizations.of(context)!
                                .password_length;
                          }
                          // Add additional password strength checks as needed
                          // For example, you can check for the presence of uppercase letters, lowercase letters, numbers, and special characters

                          // Example: Check for lowercase letters
                          final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
                          if (!hasLowercase) {
                            return AppLocalizations.of(context)!
                                .lowercase_letters;
                          }

                          // Example: Check for uppercase letters
                          final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
                          if (!hasUppercase) {
                            return AppLocalizations.of(context)!
                                .uppercase_letters;
                          }

                          // Example: Check for numbers
                          final hasNumber = RegExp(r'[0-9]').hasMatch(value);
                          if (!hasNumber) {
                            return AppLocalizations.of(context)!.numbers;
                          }

                          // Example: Check for special characters
                          final hasSpecialCharacters =
                              RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
                          if (!hasSpecialCharacters) {
                            return AppLocalizations.of(context)!
                                .special_characters;
                          }
                          if (controller.passwordController.value !=
                              controller.confirmPasswordController.value) {
                            return AppLocalizations.of(context)!.password_match;
                          }
                          // Password meets all criteria, so return null indicating validation passed
                          return null;
                        },
                        isicon2: true,
                        onPressed: () {
                          loginController.passToggle.value =
                              !loginController.passToggle.value;
                        },
                        icon2: loginController.passToggle.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        hinttext:
                            AppLocalizations.of(context)!.confirm_password,
                        icon: Icons.lock_outline)),
                    SizedBox(
                      height: 15.h,
                    ),
                    Obx(() => controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColor.teelColor,
                            ),
                          )
                        : RoundedButton(
                            Color: AppColor.teelColor,
                            text: AppLocalizations.of(context)!.reset_password,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.isLoading.value = true;
                                controller.changePassword(
                                    email,
                                    controller.passwordController.text,
                                    controller.confirmPasswordController.text);
                              }
                            })),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
