import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/forget_password.dart';
import 'package:lawyerapp/auth_screens/signup_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/login_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Center(
            child: SingleChildScrollView(
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
                    isicon2: false,
                    controller: controller.emailController,
                    hinttext: 'Your Email',
                    icon: Icons.email_outlined,
                  ),
                  Obx(() => MyTextField(
                        isicon2: true,
                        onPressed: () {
                          controller.passToggle.value =
                              !controller.passToggle.value;
                        },
                        icon2: controller.passToggle.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        controller: controller.passwordController,
                        hinttext: 'Password',
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
                          text: 'Sign In',
                          onPressed: () {
                            controller.isLoading.value = true;
                            controller.login();
                          })),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: InkWell(
                      onTap: () {
                        Get.to(const ForgetPasswordScreen());
                      },
                      child: Text(
                        'Forget password?',
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
                          'Don\'t have an account yet? ',
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
                            'Sign Up',
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
    );
  }
}
