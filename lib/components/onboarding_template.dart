import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class OnboardingTemplate extends StatelessWidget {
  OnboardingTemplate(
      {super.key,
      required this.onBoardingImage,
      required this.heading,
      required this.decsription,
      required this.onPressed,
      required this.buttonTitle});
  final String onBoardingImage;
  final String heading;
  final String decsription;
  final VoidCallback onPressed;
  String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            onBoardingImage,
            filterQuality: FilterQuality.low,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                  child: Text(
                    heading,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.teelColor),
                  ),
                ),
                Text(
                  decsription,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'inter',
                      color: const Color.fromRGBO(107, 114, 128, 1)),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: RoundedButton(
                      Color: AppColor.teelColor,
                      text: buttonTitle,
                      onPressed: onPressed
                      // _controller.nextPage(
                      //     duration: const Duration(milliseconds: 400),
                      //     curve: Curves.easeIn);
                      ,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
