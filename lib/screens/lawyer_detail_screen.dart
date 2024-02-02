import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/screens/confirm_appointment_screen.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class LawyerDetailScreen extends StatelessWidget {
  const LawyerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lawyer Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 120,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Row(
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
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Text(
                              'Criminal Lawyer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Fee 3000',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'About me',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                  'I am a dedicated and experienced lawyer committed to providing exceptional legal services. With a passion for justice and a deep understanding of the law, I strive to advocate for my clients\' rights and navigate them through legal challenges.'),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Education',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                  'Juris Doctor (JD) from [Law School Name], [Year]\nBachelor of Laws (LLB) from [University Name], [Year]'),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                  '123 Legal Street Suite 456 Justice City, JD 54321 Legaland'),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Working Time',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
              Text('Monday-Friday 8:00 AM to 9:00 PM'),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Experience',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
              Text('2 Years at Justice Advocates LLP'),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Contact',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
              Text('213124141'),
              SizedBox(
                height: 20.h,
              ),
              RoundedButton(
                  Color: AppColor.teelColor,
                  text: 'Book Appointment',
                  onPressed: () {
                    Get.to(ConfirmAppointmentScreen());
                  }),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
