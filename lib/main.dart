import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/language_controller.dart';
import 'package:lawyerapp/controllers/lawyer_categories_controller.dart';
import 'package:lawyerapp/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

int onboardingStatus = 0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  String? selectedLanguage = await storage.read(key: 'language');

  final languageController = Get.put(LanguageController());
  if (selectedLanguage != null) {
    await languageController.changeLanguage(selectedLanguage);
  }
  // final storage = FlutterSecureStorage();
  // String? selectedLanguage = await storage.read(key: 'language');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });
  final LanguageController controller = Get.put(LanguageController());
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
      locale: Locale(controller.currentLanguage),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData(
        fontFamily: controller.currentLanguage == 'en' ? 'Inter' : 'Tajawal',
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(17, 25, 40, 1)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
