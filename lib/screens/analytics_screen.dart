import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/components/analytics_view_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.teelColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.analytics,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                    heading:
                        AppLocalizations.of(context)!.upcoming_appointments,
                    icon: Icons.calendar_month,
                    value: 10),
                SizedBox(
                  height: 10.h,
                ),
                AnalyticsViewTemplate(
                    heading:
                        AppLocalizations.of(context)!.completed_appointments,
                    icon: Icons.calendar_month,
                    value: 5),
                SizedBox(
                  height: 10.h,
                ),
                AnalyticsViewTemplate(
                    heading:
                        AppLocalizations.of(context)!.cancelled_appointments,
                    icon: Icons.calendar_month,
                    value: 5),
                SizedBox(
                  height: 10.h,
                ),
                AnalyticsViewTemplate(
                    heading: AppLocalizations.of(context)!.total_appointments,
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
