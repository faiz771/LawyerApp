import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/forgot_password_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Center(
                            child: Image.asset(
                          'assets/images/lawyerapp-logo.png',
                          scale: 3,
                        )),
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
                          AppLocalizations.of(context)!.forgotpassword,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.please_enter_email,
                            style: TextStyle(fontSize: 14.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
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
                              text: AppLocalizations.of(context)!.send_code,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.isLoading.value = true;
                                  controller.sendForgotEmail(
                                      controller.emailController.text);
                                }
                              })),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
