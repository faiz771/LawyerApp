import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/components/calendar_template.dart';
import 'package:lawyerapp/components/custom_dialog.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:lightweight_calendar/global_utils.dart';
import 'package:lightweight_calendar/lightweight_calendar_app.dart';

class ConfirmAppointmentScreen extends StatefulWidget {
  @override
  _ConfirmAppointmentScreenState createState() =>
      _ConfirmAppointmentScreenState();
}

class _ConfirmAppointmentScreenState extends State<ConfirmAppointmentScreen> {
  String selectedButton = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Book Appointment',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  'Select Date',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CalendarTemplate(),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  'Select Hour',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 10.0.w,
                    runSpacing: 8.0,
                    children: [
                      buildSelectableButton('10:00 AM'),
                      buildSelectableButton('10:30 AM'),
                      buildSelectableButton('11:00 AM'),
                      buildSelectableButton('11:30 AM'),
                      buildSelectableButton('12:00 PM'),
                      buildSelectableButton('12:30 PM'),
                      buildSelectableButton('1:00 PM'),
                      buildSelectableButton('1:30 PM'),
                      buildSelectableButton('2:00 PM'),
                      buildSelectableButton('2:30 PM'),
                      buildSelectableButton('3:00 PM'),
                      buildSelectableButton('3:30 PM'),
                      buildSelectableButton('4:00 PM'),
                      buildSelectableButton('4:30 PM'),
                      buildSelectableButton('5:00 PM'),
                      buildSelectableButton('5:30 PM'),
                      buildSelectableButton('6:00 PM'),
                      buildSelectableButton('6:30 PM')
                      // Add more time elements as needed
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: RoundedButton(
                    Color: AppColor.teelColor,
                    text: 'Confirm',
                    onPressed: () {
                      Get.dialog(CustomDialog(
                        heading: 'Congratulations',
                        text:
                            'Your appointment with Mr. David Patel is confirmed for June 30, 2023, at 10:00 AM..',
                        buttontext: 'Ok',
                      ));
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ));
  }

  Widget buildSelectableButton(String buttonText) {
    bool isSelected = selectedButton == buttonText;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButton = isSelected ? '' : buttonText;
        });
      },
      child: Container(
        height: 30.h,
        width: 100.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color:
                isSelected ? Color.fromRGBO(17, 25, 40, 1) : Colors.grey[300]),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
