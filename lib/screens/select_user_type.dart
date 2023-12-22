import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/screens/client_homepage_screen.dart';
import 'package:lawyerapp/screens/fill_profile_screen.dart';

class SelectUserTypeScreen extends StatelessWidget {
  const SelectUserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select User Type',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 30.h,
                ),
                InkWell(
                    onTap: () {
                      Get.to(FillProfileScreen());
                    },
                    child: Image.asset('assets/images/typecard1.png')),
                SizedBox(
                  height: 30.h,
                ),
                InkWell(
                    onTap: () {
                      Get.offAll(ClientHomepage());
                    },
                    child: Image.asset('assets/images/typecard2.png')),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
