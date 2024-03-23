import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/forget_password.dart';
import 'package:lawyerapp/auth_screens/signup_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/language_controller.dart';
import 'package:lawyerapp/controllers/login_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.emailController.clear();
    controller.passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
                onTap: () {
                  showLanguageDialog(context);
                },
                child: Icon(EvaIcons.globe)),
          ),
        ]),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                      child: Center(
                          child: Image.asset(
                        'assets/images/lawyerapp-logo.png',
                        scale: 3,
                      )),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    //   child: Center(
                    //     child: Text(
                    //       'LawyerConnect',
                    //       style: TextStyle(
                    //           fontSize: 20.sp, fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    //   child: Center(
                    //     child: Text(
                    //       'Hope you\'re doing fine.',
                    //       style: TextStyle(fontSize: 14.sp),
                    //     ),
                    //   ),
                    // ),
                    MyTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.email_empty;
                        }
                        // Regular expression for email validation
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return AppLocalizations.of(context)!
                              .invalid_email_format;
                        }
                        return null; // Return null if the validation passes
                      },
                      isicon2: false,
                      controller: controller.emailController,
                      hinttext: AppLocalizations.of(context)!.email,
                      icon: Icons.email_outlined,
                    ),
                    Obx(() => MyTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .password_empty;
                            }
                            if (value.length < 8) {
                              return AppLocalizations.of(context)!
                                  .password_length;
                            }
                            // Add additional password strength checks as needed
                            // For example, you can check for the presence of uppercase letters, lowercase letters, numbers, and special characters

                            // Example: Check for lowercase letters
                            // final hasLowercase =
                            //     RegExp(r'[a-z]').hasMatch(value);
                            // if (!hasLowercase) {
                            //   return 'Password must contain lowercase letters';
                            // }

                            // // Example: Check for uppercase letters
                            // final hasUppercase =
                            //     RegExp(r'[A-Z]').hasMatch(value);
                            // if (!hasUppercase) {
                            //   return 'Password must contain uppercase letters';
                            // }

                            // // Example: Check for numbers
                            // final hasNumber = RegExp(r'[0-9]').hasMatch(value);
                            // if (!hasNumber) {
                            //   return 'Password must contain numbers';
                            // }

                            // // Example: Check for special characters
                            // final hasSpecialCharacters =
                            //     RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                            //         .hasMatch(value);
                            // if (!hasSpecialCharacters) {
                            //   return 'Password must contain special characters';
                            // }

                            // Password meets all criteria, so return null indicating validation passed
                            return null;
                          },
                          isicon2: true,
                          onPressed: () {
                            controller.passToggle.value =
                                !controller.passToggle.value;
                          },
                          icon2: controller.passToggle.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          controller: controller.passwordController,
                          hinttext: AppLocalizations.of(context)!.password,
                          icon: Icons.lock_outline,
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    Obx(() => controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: AppColor.teelColor,
                          )
                        : RoundedButton(
                            Color: AppColor.teelColor,
                            text: AppLocalizations.of(context)!.signin,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Validation passed, perform sign-up
                                // For demo, just print the email and password
                                controller.isLoading.value = true;
                                controller.login();
                              }
                            })),
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: InkWell(
                        onTap: () {
                          Get.to(ForgetPasswordScreen());
                        },
                        child: Text(
                          '${AppLocalizations.of(context)!.forgotpassword}?',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.donthaveaccount + ' ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color.fromRGBO(107, 114, 128, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(const SignUpScreen());
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signup,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showLanguageDialog(BuildContext context) {
    final LanguageController languageController = Get.put(LanguageController());
    String currentLanguage = languageController.currentLanguage;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                // padding: EdgeInsets.only(
                //   top: 20.0,
                //   bottom: 16.0,
                //   left: 16.0,
                //   right: 16.0,
                // ),
                margin: EdgeInsets.only(top: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      // height: 80,
                      decoration: BoxDecoration(
                          color: AppColor.teelColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.choose_language,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Positioned(
                              right: 16.0,
                              top: 16.0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ListTile(
                      onTap: () async {
                        await languageController.changeLanguage('en');
                        Navigator.pop(context, 'en');
                      },
                      title: Text(
                        'English',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: currentLanguage == 'en'
                              ? AppColor.teelColor
                              : Colors.black,
                        ),
                      ),
                      leading: Radio(
                        activeColor: AppColor.teelColor,
                        value: 'en',
                        groupValue: currentLanguage,
                        onChanged: (String? value) async {
                          await languageController.changeLanguage(value!);
                          Navigator.pop(context, value);
                        },
                      ),
                    ),
                    // Divider(
                    //   color: AppColor.teelColor,
                    // ),
                    ListTile(
                      onTap: () async {
                        await languageController.changeLanguage('ar');
                        Navigator.pop(context, 'ar');
                      },
                      title: Text(
                        'العربية',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: currentLanguage == 'ar'
                              ? AppColor.teelColor
                              : Colors.black,
                        ),
                      ),
                      leading: Radio(
                        activeColor: AppColor.teelColor,
                        value: 'ar',
                        groupValue: currentLanguage,
                        onChanged: (String? value) async {
                          await languageController.changeLanguage(value!);
                          Navigator.pop(context, value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
