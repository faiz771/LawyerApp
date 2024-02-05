import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/screens/lawyer_detail_screen.dart';

class LawyerGridViewTemplate extends StatelessWidget {
  const LawyerGridViewTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MasonryGridView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          // shrinkWrap: true,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: 10,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(const LawyerDetailScreen());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 5.h),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue, width: 5)),
                          child: CircleAvatar(
                            radius: 50.h,
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/onboard1.jpg',
                                      ))),
                            ),
                          ),
                        ),
                      ),
                      // const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Mr.Syed Muhammad Talha',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Center(
                                child: Text('Criminal Lawyer',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis))),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Available',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis)),
                                Text('Fee 30000',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
