import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/components/notification_template.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Notificationscreen extends StatelessWidget {
  const Notificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColor.teelColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.notifications,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  '1 New',
                  style: TextStyle(
                      color: AppColor.teelColor, fontWeight: FontWeight.bold),
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
