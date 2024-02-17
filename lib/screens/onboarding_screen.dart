import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/components/onboarding_template.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final _controller = PageController();

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  UserController controller = Get.put(UserController());

  Future<void> _incrementOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onboardingStatus', 1);
    setState(() {
      onboardingStatus = 1;
    });
  }

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
                    buttonTitle: "Next",
                    onBoardingImage: 'assets/images/onboarding1.jpg',
                    heading: 'Secure Consultation',
                    decsription:
                        'Embark on a hassle-free legal journey with Us. Effortlessly find and connect with skilled attorneys who specialize in your specific needs. Streamline your appointments, receive timely reminders, and take control of your legal matters with confidence',
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  OnboardingTemplate(
                    buttonTitle: "Next",
                    onBoardingImage: 'assets/images/onboarding2.jpg',
                    heading: 'Transparent Pricing',
                    decsription:
                        'No surprises, just clarity. Explore transparent pricing models before booking appointments, and rest assured that you have a clear understanding of costs, making your legal journey straightforward, predictable, and budget-friendly',
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  OnboardingTemplate(
                    buttonTitle: 'Get Started',
                    onBoardingImage: 'assets/images/onboarding3.jpg',
                    heading: 'Appointment Reminders',
                    decsription:
                        'Stay on top of your legal agenda effortlessly. Receive timely reminders for upcoming appointments, ensuring you never miss a crucial consultation.Moza Al-Shehhi Law Firm making your legal journey a seamless experience.',
                    onPressed: () {
                      _incrementOnboardingStatus();
                      controller.getUserDetails();
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
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Color.fromRGBO(17, 25, 40, 1),
                      ),
                      controller: _controller,
                      count: 3,
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 40,
                      width: 80,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          _incrementOnboardingStatus();
                          controller.getUserDetails();
                        },
                        child: const Row(
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
