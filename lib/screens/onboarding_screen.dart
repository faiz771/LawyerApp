import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/components/onboarding_template.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/main.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  Future<void> storeLanguage(String language) async {
    final storage = FlutterSecureStorage();
    try {
      await storage.write(key: 'language', value: language);
      print('language changed');
    } catch (e) {
      print('Error writing to secure storage: $e');
    }
  }

  void checkLanguageSelected() async {
    final storage = FlutterSecureStorage();
    String? selectedLanguage = await storage.read(key: 'language');
    selectedLanguage == null ? showLanguageDialog(context) : null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguageSelected();
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
                        'Embark on a hassle-free legal journey with Us. Effortlessly find and connect with skilled attorneys who specialize in your specific needs. Streamline your appointments, receive timely reminders, and take control of your legal matters.',
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

  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                margin: EdgeInsets.only(top: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.choose_language,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    InkWell(
                      onTap: () async {
                        // Change language to English
                        await storeLanguage('en');
                        Navigator.pop(context, 'en');
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'English',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () async {
                        // Change language to Arabic
                        await storeLanguage('ar');
                        Navigator.pop(context, 'ar');
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'العربية',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16.0,
                top: 16.0,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColor.teelColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
