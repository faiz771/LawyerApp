import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/components/doctor_grid_view_template.dart';
import 'package:lawyerapp/components/filter_dropdown_button.dart';
import 'package:lawyerapp/components/mytextfield.dart';

class AllLawyerScreen extends StatefulWidget {
  const AllLawyerScreen({super.key});

  @override
  State<AllLawyerScreen> createState() => _AllLawyerScreenState();
}

class _AllLawyerScreenState extends State<AllLawyerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Lawyers'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            MyTextField(hinttext: 'Search', icon: Icons.search),
            SizedBox(
              height: 10.h,
            ),
            FilterDropDownButton(),
            DoctorGridViewTemplate()
          ],
        ),
      ),
    );
  }
}
