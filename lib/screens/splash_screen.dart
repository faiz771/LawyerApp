import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/main.dart';
import 'package:lawyerapp/screens/onboarding_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  UserController controller = Get.put(UserController());

  // Load onboarding status from SharedPreferences
  Future<void> _loadOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      onboardingStatus = prefs.getInt('onboardingStatus') ?? 0;
    });
    if (onboardingStatus == 1) {
      controller.getUserDetails();
    } else if (onboardingStatus == 0) {
      Get.to(const OnboardingScreen());
    }
  }

  // Navigate to appropriate screen based on onboarding status
  // Here you can navigate to the home page or the onboarding screen

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start the animation
    _controller.forward();
    Future.delayed(const Duration(seconds: 4), () {
      _loadOnboardingStatus();
      // Navigate to the next screen after the delay
      // Navigator.pushReplacement(
      //   context,
      //   PageRouteBuilder(
      //     pageBuilder: (context, animation, secondaryAnimation) =>
      //         const OnboardingScreen(),
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       const begin = Offset(1.0, 0.0);
      //       const end = Offset.zero;
      //       const curve = Curves.easeInOut;

      //       var tween =
      //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      //       var offsetAnimation = animation.drive(tween);

      //       return SlideTransition(position: offsetAnimation, child: child);
      //     },
      //   ),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // ColorFiltered(
              //   colorFilter: ColorFilter.mode(
              //     Colors.black.withOpacity(
              //         0.7), // Adjust the opacity value (0.0 to 1.0)
              //     BlendMode.dstATop,
              //   ),
              //   child: Container(
              //       width: double.infinity,
              //       child: Image.asset(
              //         'assets/images/splash.jpg',
              //         fit: BoxFit.cover,
              //       )),
              // ),
              FadeTransition(
                opacity: _opacity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/lawyerapp-logo.png",
                        scale: 2.8,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Appname',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
              // AnimatedSplashScreen(
              //   splash: 'assets/images/splash.jpg',
              //   splashIconSize: double.infinity,
              //   nextScreen: OnboardingScreen(),
              //   splashTransition: SplashTransition.fadeTransition,
              //   pageTransitionType: PageTransitionType.rightToLeft,
              //   curve: Curves.easeIn,
              //   centered: true,
              // ),
            ],
          )),
    );
  }
}
