import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/components/analytics_view_template.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Analytics',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                AnalyticsViewTemplate(
                    heading: 'Upcoming Appointments',
                    icon: Icons.calendar_month,
                    value: 10),
                SizedBox(
                  height: 10.h,
                ),
                AnalyticsViewTemplate(
                    heading: 'Completed Appointments',
                    icon: Icons.calendar_month,
                    value: 5),
                SizedBox(
                  height: 10.h,
                ),
                AnalyticsViewTemplate(
                    heading: 'Cancelled Appointments',
                    icon: Icons.calendar_month,
                    value: 5),
                SizedBox(
                  height: 10.h,
                ),
                AnalyticsViewTemplate(
                    heading: 'Total Appointments',
                    icon: Icons.calendar_month,
                    value: 20),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
