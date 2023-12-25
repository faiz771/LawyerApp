import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalyticsViewTemplate extends StatelessWidget {
  AnalyticsViewTemplate(
      {super.key,
      required this.heading,
      required this.icon,
      required this.value});
  String heading = '';
  int value = 0;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]),
      height: 150,
      width: 320.w,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  heading,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$value',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Icon(
              icon,
              size: 30.h,
            )
          ],
        ),
      ),
    );
  }
}
