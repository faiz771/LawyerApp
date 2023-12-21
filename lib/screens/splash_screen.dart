import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/screens/onboarding_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';

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
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Adjust the duration as needed
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start the animation
    _controller.forward();
    Future.delayed(Duration(seconds: 4), () {
      // Navigate to the next screen after the delay
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(
                      0.7), // Adjust the opacity value (0.0 to 1.0)
                  BlendMode.dstATop,
                ),
                child: Container(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/splash.jpg',
                      fit: BoxFit.cover,
                    )),
              ),
              FadeTransition(
                opacity: _opacity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/splogo.png",
                        scale: 4,
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
