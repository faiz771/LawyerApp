import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TwoRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String text2;
  final VoidCallback onPressed2;

  const TwoRoundedButton({
    required this.text,
    required this.onPressed,
    required this.text2,
    required this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(17, 25, 40, 1), // Button background color
              borderRadius: BorderRadius.circular(20.0), // Rounded corners
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: onPressed2,
          child: Container(
            // width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(17, 25, 40, 1), // Button background color
              borderRadius: BorderRadius.circular(20.0), // Rounded corners
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 15.w),
                child: Text(
                  text2,
                  style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
