import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/components/doctor_slider_view_template.dart';
import 'package:lawyerapp/components/filter_dropdown_button.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/promotion_slider_view_template.dart';
import 'package:lawyerapp/screens/all_lawyer_screen.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyTextField(hinttext: 'Search', icon: Icons.search),
              SizedBox(
                height: 10.h,
              ),
              PromotionSliderViewTemplate(),
              //FilterDropDownButton(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: 10.w, top: 2.h, bottom: 2.h),
                    child: InkWell(
                        onTap: () {
                          Get.to(AllLawyerScreen());
                        },
                        child: Text('See All')),
                  ),
                  DoctorSliderViewTemplate(),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
