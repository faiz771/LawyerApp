import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/components/onboarding_template.dart';
import 'package:lawyerapp/controllers/language_controller.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/main.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    buttonTitle: AppLocalizations.of(context)!.next,
                    onBoardingImage: 'assets/images/onboarding1.jpg',
                    heading: AppLocalizations.of(context)!.secure_Consultation,
                    decsription: AppLocalizations.of(context)!.onboarding1,
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  OnboardingTemplate(
                    buttonTitle: AppLocalizations.of(context)!.next,
                    onBoardingImage: 'assets/images/onboarding2.jpg',
                    heading: AppLocalizations.of(context)!.transparent_Pricing,
                    decsription: AppLocalizations.of(context)!.onboarding2,
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  OnboardingTemplate(
                    buttonTitle: AppLocalizations.of(context)!.get_started,
                    onBoardingImage: 'assets/images/onboarding3.jpg',
                    heading:
                        AppLocalizations.of(context)!.appointment_Reminders,
                    decsription: AppLocalizations.of(context)!.onboarding3,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.skip,
                            ),
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
    final LanguageController languageController = Get.put(LanguageController());
    String currentLanguage = languageController.currentLanguage;

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
                // padding: EdgeInsets.only(
                //   top: 20.0,
                //   bottom: 16.0,
                //   left: 16.0,
                //   right: 16.0,
                // ),
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
                    Container(
                      width: double.infinity,
                      // height: 80,
                      decoration: BoxDecoration(
                          color: AppColor.teelColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.choose_language,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ListTile(
                      onTap: () async {
                        await languageController.changeLanguage('en');
                        Navigator.pop(context, 'en');
                      },
                      title: Text(
                        'English',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: currentLanguage == 'en'
                              ? AppColor.teelColor
                              : Colors.black,
                        ),
                      ),
                      leading: Radio(
                        activeColor: AppColor.teelColor,
                        value: 'en',
                        groupValue: currentLanguage,
                        onChanged: (String? value) async {
                          await languageController.changeLanguage(value!);
                          Navigator.pop(context, value);
                        },
                      ),
                    ),
                    // Divider(
                    //   color: AppColor.teelColor,
                    // ),
                    ListTile(
                      onTap: () async {
                        await languageController.changeLanguage('ar');
                        Navigator.pop(context, 'ar');
                      },
                      title: Text(
                        'العربية',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: currentLanguage == 'ar'
                              ? AppColor.teelColor
                              : Colors.black,
                        ),
                      ),
                      leading: Radio(
                        activeColor: AppColor.teelColor,
                        value: 'ar',
                        groupValue: currentLanguage,
                        onChanged: (String? value) async {
                          await languageController.changeLanguage(value!);
                          Navigator.pop(context, value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
