import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lawyerapp/components/custom_dialog.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/login_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Center(
                        child: Image.asset(
                      'assets/images/lawyerlogo.jpg',
                      scale: 7,
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                    child: Center(
                      child: Text(
                        'LawyerConnect',
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Create New Password',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    child: Center(
                      child: Text(
                        'Your new password must be different form previously used password',
                        style: TextStyle(fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Obx(() => MyTextField(
                      isicon2: true,
                      onPressed: () {
                        loginController.passToggle.value =
                            !loginController.passToggle.value;
                      },
                      icon2: loginController.passToggle.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      hinttext: 'Password',
                      icon: Icons.email_outlined)),
                  Obx(() => MyTextField(
                      isicon2: true,
                      onPressed: () {
                        loginController.passToggle.value =
                            !loginController.passToggle.value;
                      },
                      icon2: loginController.passToggle.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      hinttext: 'Confirm Password',
                      icon: Icons.email_outlined)),
                  SizedBox(
                    height: 15.h,
                  ),
                  RoundedButton(
                      Color: AppColor.teelColor,
                      text: 'Reset Password',
                      onPressed: () {
                        Get.dialog(CustomDialog(
                          heading: 'Congratulations',
                          text: 'Your password is successfuly changed',
                          buttontext: 'Login',
                        ));
                      }),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
