import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/auth_screens/forget_password.dart';
import 'package:lawyerapp/auth_screens/signup_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/screens/fill_profile_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Center(
                      child: Image.asset(
                    'assets/images/logo.png',
                    scale: 3.5,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                  child: Center(
                    child: Text(
                      '(Appname)',
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Hi, Welcome Back!',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                  child: Center(
                    child: Text(
                      'Hope you\'re doing fine.',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
                MyTextField(hinttext: 'Your Email', icon: Icons.email_outlined),
                MyTextField(hinttext: 'Password', icon: Icons.lock_outline),
                SizedBox(
                  height: 15.h,
                ),
                RoundedButton(text: 'Sign In', onPressed: () {}),
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: InkWell(
                    onTap: () {
                      Get.to(ForgetPasswordScreen());
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
                          color: Color.fromRGBO(107, 114, 128, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(SignUpScreen());
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
    );
  }
}
