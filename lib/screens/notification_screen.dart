import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/components/notification_template.dart';

class Notificationscreen extends StatelessWidget {
  const Notificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(17, 25, 40, 1),
                  borderRadius: BorderRadius.circular(6)),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  '1 New',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TODAY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Text(
                      'Mark all as read',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              NotificationTemplate(
                image: 'assets/images/successnoti.png',
                text:
                    'You have successfully booked your appointment with Ms. Emily Walker.',
                heading: 'Appointment Success',
              ),
              NotificationTemplate(
                image: 'assets/images/cancellednoti.png',
                text:
                    'You have successfully booked your appointment with Ms. Emily Walker.',
                heading: 'Appointment Cancelled',
              ),
              NotificationTemplate(
                image: 'assets/images/reschedulenoti.png',
                text:
                    'You have successfully booked your appointment with Ms. Emily Walker.',
                heading: 'Appoinment Reschduled',
              )
            ],
          ),
        ),
      ),
    );
  }
}
