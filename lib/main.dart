import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/change_password_screen.dart';
import 'package:lawyerapp/auth_screens/verify_otp_screen.dart';
import 'package:lawyerapp/controllers/lawyer_categories_controller.dart';
import 'package:lawyerapp/screens/chat_bot_screen.dart';
import 'package:lawyerapp/screens/client_homepage_screen.dart';
import 'package:lawyerapp/screens/lawyer_homepage_screen.dart';
import 'package:lawyerapp/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

int onboardingStatus = 0;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(LawyerCategoriesController());
      }),
      title: 'MOZA AL-SHEHHI LAW FIRM',
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(17, 25, 40, 1)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
