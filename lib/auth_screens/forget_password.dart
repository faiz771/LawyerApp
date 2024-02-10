import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
                      'Forget Password?',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    child: Center(
                      child: Text(
                        'Enter your Email, we will send you a verification code.',
                        style: TextStyle(fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  MyTextField(
                      isicon2: false,
                      hinttext: 'Your Email',
                      icon: Icons.email_outlined),
                  SizedBox(
                    height: 15.h,
                  ),
                  RoundedButton(
                      Color: AppColor.teelColor,
                      text: 'Send Code',
                      onPressed: () {
                        // Get.to( VerifyOtpScreen());
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
