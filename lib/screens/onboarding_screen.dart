import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/signup_screen.dart';
import 'package:lawyerapp/components/onboarding_template.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final _controller = PageController();

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                children: [
                  OnboardingTemplate(
                    onBoardingImage: 'assets/images/onboard1.jpg',
                    heading: 'Secure Consultation',
                    decsription:
                        'Embark on a hassle-free legal journey with (Appname). Effortlessly find and connect with skilled attorneys who specialize in your specific needs. Streamline your appointments, receive timely reminders, and take control of your legal matters with confidence',
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  OnboardingTemplate(
                    onBoardingImage: 'assets/images/onboard2.jpg',
                    heading: 'Transparent Pricing',
                    decsription:
                        'No surprises, just clarity. Explore transparent pricing models before booking appointments, and rest assured that (Appname) ensures you have a clear understanding of costs, making your legal journey straightforward, predictable, and budget-friendly',
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  OnboardingTemplate(
                    onBoardingImage: 'assets/images/onboard3.jpg',
                    heading: 'Appointment Reminders',
                    decsription:
                        'Stay on top of your legal agenda effortlessly. Receive timely reminders for upcoming appointments, ensuring you never miss a crucial consultation. LegalConnect is designed to keep you informed and in control, making your legal journey a seamless experience.',
                    onPressed: () {
                      Get.to(SignUpScreen());
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    SmoothPageIndicator(
                      effect: ExpandingDotsEffect(
                        activeDotColor: Color.fromRGBO(17, 25, 40, 1),
                      ),
                      controller: _controller,
                      count: 3,
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(SignUpScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Skip'),
                          SizedBox(
                              width:
                                  8), // Adjust spacing between label and icon
                          Icon(
                            Icons.arrow_forward,
                            color: Color.fromRGBO(17, 25, 40, 1),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
