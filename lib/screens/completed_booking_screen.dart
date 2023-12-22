import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/components/rounded_button.dart';

class CompletedBookingScreen extends StatelessWidget {
  const CompletedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 230,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'May 22, 2023 - 10.00 AM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
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
                            Text(
                              'Mr.John Doe William',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Criminal Lawyer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
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
                  Divider(),
                  RoundedButton(text: 'Re-book', onPressed: () {})
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     ElevatedButton(
                  //         style: ButtonStyle(
                  //             backgroundColor:
                  //                 MaterialStatePropertyAll(Colors.grey[300])),
                  //         onPressed: () {},
                  //         child: Padding(
                  //           padding: EdgeInsets.symmetric(horizontal: 10.w),
                  //           child: Text(
                  //             'Cancel',
                  //             style: TextStyle(
                  //                 color: Color.fromRGBO(17, 25, 40, 1),
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         )),
                  //     ElevatedButton(
                  //         style: ButtonStyle(
                  //             backgroundColor: MaterialStatePropertyAll(
                  //                 Color.fromRGBO(17, 25, 40, 1))),
                  //         onPressed: () {},
                  //         child: Padding(
                  //           padding: EdgeInsets.symmetric(horizontal: 10.w),
                  //           child: Text(
                  //             'Reschedule',
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         )),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
