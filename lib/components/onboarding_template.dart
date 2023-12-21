import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/components/rounded_button.dart';

class OnboardingTemplate extends StatelessWidget {
  const OnboardingTemplate({
    super.key,
    required this.onBoardingImage,
    required this.heading,
    required this.decsription,
    required this.onPressed,
  });
  final String onBoardingImage;
  final String heading;
  final String decsription;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            onBoardingImage,
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
                        color: Color.fromRGBO(17, 25, 40, 1)),
                  ),
                ),
                Text(
                  decsription,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'inter',
                      color: Color.fromRGBO(107, 114, 128, 1)),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: RoundedButton(
                      text: 'Next',
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
