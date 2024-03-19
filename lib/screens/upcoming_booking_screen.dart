import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class UpcomingBookingScreen extends StatelessWidget {
  UpcomingBookingScreen({
    super.key,
    required this.button1,
    required this.onPressed1,
    required this.button1title,
  });
  bool button1 = false;

  String button1title = '';

  final VoidCallback onPressed1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'May 22, 2023 - 10.00 AM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/onboard3.jpg',
                                    )))),
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mr.John Doe William',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            const Text(
                              'Criminal Lawyer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            const Text(
                              'Fee 3000',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  // const Divider(),
                  // RoundedButton(
                  //     text: button1title,
                  //     onPressed: onPressed1,
                  //     Color: AppColor.teelColor)
                  // button1 & button2
                  //     ? Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           button1
                  //               ? ElevatedButton(
                  //                   style: ButtonStyle(
                  //                       backgroundColor:
                  //                           MaterialStatePropertyAll(
                  //                               Colors.grey[300])),
                  //                   onPressed: onPressed1,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.symmetric(
                  //                         horizontal: 10.w),
                  //                     child: Text(
                  //                       button1title,
                  //                       style: const TextStyle(
                  //                           color:
                  //                               Color.fromRGBO(17, 25, 40, 1),
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                   ))
                  //               : const SizedBox(),
                  //           button2
                  //               ? ElevatedButton(
                  //                   style: const ButtonStyle(
                  //                       backgroundColor:
                  //                           MaterialStatePropertyAll(
                  //                               Color.fromRGBO(17, 25, 40, 1))),
                  //                   onPressed: onPressed2,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.symmetric(
                  //                         horizontal: 10.w),
                  //                     child: Text(
                  //                       button2title,
                  //                       style: const TextStyle(
                  //                           color: Colors.white,
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                   ))
                  //               : const SizedBox.shrink()
                  //         ],
                  //       )
                  //     : RoundedButton(
                  //         Color: AppColor.teelColor,
                  //         text: button2title,
                  //         onPressed: onPressed2)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
