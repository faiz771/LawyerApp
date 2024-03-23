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

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
                child: const Icon(EvaIcons.globe)),
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
                            '${AppLocalizations.of(context)!.donthaveaccount} ',
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

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              //   width: double.infinity,
              // height: 80,
              decoration: BoxDecoration(
                  color: AppColor.teelColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.choose_language,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () async {
                await languageController.changeLanguage('en');
                Navigator.pop(context, 'en');
              },
              child: Container(
                child: Row(
                  children: [
                    Radio(
                      activeColor: AppColor.teelColor,
                      value: 'en',
                      groupValue: currentLanguage,
                      onChanged: (String? value) async {
                        await languageController.changeLanguage(value!);
                        Navigator.pop(context, value);
                      },
                    ),
                    Text(
                      'English',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: currentLanguage == 'en'
                            ? AppColor.teelColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ListTile(

            //   title:
            //   leading:
            // ),
            // // Divider(
            //   color: AppColor.teelColor,
            // ),
            InkWell(
              onTap: () async {
                await languageController.changeLanguage('ar');
                Navigator.pop(context, 'ar');
              },
              child: Container(
                child: Row(
                  children: [
                    Radio(
                      activeColor: AppColor.teelColor,
                      value: 'ar',
                      groupValue: currentLanguage,
                      onChanged: (String? value) async {
                        await languageController.changeLanguage(value!);
                        Navigator.pop(context, value);
                      },
                    ),
                    Text(
                      'العربية',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: currentLanguage == 'ar'
                            ? AppColor.teelColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ListTile(

            //   title:
            //   leading:
            // ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
