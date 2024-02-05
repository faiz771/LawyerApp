import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomepageIconsWithTextTemplate extends StatelessWidget {
  const HomepageIconsWithTextTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(17, 25, 40, 1),
            ),
            height: 80.h,
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'About Us',
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(17, 25, 40, 1),
            ),
            height: 80.h,
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Appointment',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(17, 25, 40, 1),
            ),
            height: 80.h,
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.build,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Services',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
