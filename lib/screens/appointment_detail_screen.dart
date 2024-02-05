import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appointment Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
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
                      offset: const Offset(0, 3),
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
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/onboard3.jpg',
                                    )))),
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      const Expanded(
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
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                  'I am a dedicated and experienced lawyer committed to providing exceptional legal services. With a passion for justice and a deep understanding of the law, I strive to advocate for my clients\' rights and navigate them through legal challenges.'),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Appointment Time',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
              const Text('2:00 PM to 3:00 PM'),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Appointment Date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
              const Text('May 22, 2023'),
              SizedBox(
                height: 10.h,
              ),
              // Text(
              //   'Working Time',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              //   overflow: TextOverflow.ellipsis,
              // ),
              // Text('Monday-Friday 8:00 AM to 9:00 PM'),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(
              //   'Experience',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              //   overflow: TextOverflow.ellipsis,
              // ),
              // Text('2 Years at Justice Advocates LLP'),
              // SizedBox(
              //   height: 10.h,
              // ),
              Text(
                'Contact',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
              const Text('213124141'),
              SizedBox(
                height: 20.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey[300])),
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: const Text(
                          'Reject',
                          style: TextStyle(
                              color: Color.fromRGBO(17, 25, 40, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(17, 25, 40, 1))),
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: const Text(
                          'Accept',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
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
