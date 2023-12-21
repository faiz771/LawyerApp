import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/components/doctor_view_template.dart';
import 'package:lawyerapp/components/filter_dropdown_button.dart';
import 'package:lawyerapp/components/mytextfield.dart';

class ClientHomepage extends StatefulWidget {
  const ClientHomepage({super.key});

  @override
  State<ClientHomepage> createState() => _ClientHomepageState();
}

class _ClientHomepageState extends State<ClientHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.notifications)),
          )
        ],
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
            DoctorViewTemplate()
          ],
        ),
      ),
    );
  }
}
