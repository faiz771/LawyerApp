import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/components/rounded_button.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({
    super.key,
    required this.heading,
    required this.text,
    required this.buttontext,
  });
  String heading = '';
  String text = '';
  String buttontext = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          surfaceTintColor: Colors.white,
          // Set background color to transparent
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 20.h, bottom: 10.h, left: 20.w, right: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/dialog.png",
                  scale: 3,
                ),
                SizedBox(height: 16),
                Text(
                  heading,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  text,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                RoundedButton(
                  text: buttontext,
                  onPressed: () {
                    Get.back();
                  },
                  //Get.bac{k();
                ),
                SizedBox(height: 5),
                TextButton(
                    onPressed: () {}, child: Text('Edit your appointment'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
