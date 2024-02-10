import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/role_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class SelectRoleScreen extends StatelessWidget {
  String email = '';
  SelectRoleScreen({super.key, required this.email});
  final RoleController controller = Get.put(RoleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select Role',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(
                  () => InkWell(
                      onTap: () {
                        controller.selectImage(1);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: controller.selectedValue.value == 1
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2)),
                          child: Image.asset('assets/images/typecard1.png'))),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(
                  () => InkWell(
                      onTap: () {
                        controller.selectImage(2);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: controller.selectedValue.value == 2
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2)),
                          child: Image.asset('assets/images/typecard2.png'))),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(() => controller.isLoading.value
                    ? CircularProgressIndicator(
                        color: AppColor.teelColor,
                      )
                    : RoundedButton(
                        text: 'Submit',
                        onPressed: () {
                          controller.isLoading.value = true;
                          controller.updateRole(email);
                        },
                        Color: AppColor.teelColor))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
