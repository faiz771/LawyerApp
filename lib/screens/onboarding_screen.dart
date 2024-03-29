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
    const storage = FlutterSecureStorage();
    try {
      await storage.write(key: 'language', value: language);
      print('language changed');
    } catch (e) {
      print('Error writing to secure storage: $e');
    }
  }

  void checkLanguageSelected() async {
    const storage = FlutterSecureStorage();
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
                            const SizedBox(
                                width:
                                    8), // Adjust spacing between label and icon
                            const Icon(
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

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              //   width: double.infinity,
              // height: 80,
              decoration: BoxDecoration(
                  color: AppColor.teelColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.choose_language,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () async {
                await languageController.changeLanguage('en');
                Navigator.pop(context, 'en');
              },
              child: Container(
                child: Row(
                  children: [
                    Radio(
                      activeColor: AppColor.teelColor,
                      value: 'en',
                      groupValue: currentLanguage,
                      onChanged: (String? value) async {
                        await languageController.changeLanguage(value!);
                        Navigator.pop(context, value);
                      },
                    ),
                    Text(
                      'English',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: currentLanguage == 'en'
                            ? AppColor.teelColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ListTile(

            //   title:
            //   leading:
            // ),
            // // Divider(
            //   color: AppColor.teelColor,
            // ),
            InkWell(
              onTap: () async {
                await languageController.changeLanguage('ar');
                Navigator.pop(context, 'ar');
              },
              child: Container(
                child: Row(
                  children: [
                    Radio(
                      activeColor: AppColor.teelColor,
                      value: 'ar',
                      groupValue: currentLanguage,
                      onChanged: (String? value) async {
                        await languageController.changeLanguage(value!);
                        Navigator.pop(context, value);
                      },
                    ),
                    Text(
                      'العربية',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: currentLanguage == 'ar'
                            ? AppColor.teelColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ListTile(

            //   title:
            //   leading:
            // ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
