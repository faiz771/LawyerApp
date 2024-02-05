import 'dart:convert';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class LawyerProfileController extends GetxController {
  TextEditingController lawyerEducationController = TextEditingController();
  TextEditingController lawyerExperienceController = TextEditingController();
  TextEditingController lawyerAboutController = TextEditingController();
  late SingleValueDropDownController lawyerTypeController;

  Future<void> createLawyerProfile({
    required String email,
  }) async {
    final url =
        'https://lawyer-app.azsolutionspk.com/api/user/lawyer/profile/create';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'lawyer_type': lawyerTypeController.dropDownValue!.value,
          'lawyer_education': lawyerEducationController.text,
          'lawyer_experience': lawyerExperienceController.text,
          'lawyer_about': lawyerAboutController.text,
        },
      );

      final responseData = json.decode(response.body);

      if (responseData['status'] == 1) {
        // Profile creation successful
        print('Lawyer profile created successfully');
        print('Message: ${responseData['message']}');
        Get.snackbar(
          '',
          responseData['message'], // Message
          snackPosition:
              SnackPosition.BOTTOM, // Change to SnackPosition.BOTTOM for bottom
          backgroundColor: AppColor.teelColor, // Background color
          colorText: Colors.white, // Text color
          borderRadius: 10,
          snackStyle: SnackStyle.FLOATING, // Set the snack style to FLOATING
          margin: EdgeInsets
              .zero, // Remove margin to redu // BorderRadius for the snackbar
          duration: Duration(
              seconds: 3), // Duration for which the snackbar will be visible
        );
        Get.offAll(LoginScreen());
      } else {
        // Profile creation failed
        print('Lawyer profile creation failed');
        print('Message: ${responseData['message']}');
        Get.snackbar(
          '',
          responseData['message'], // Message
          snackPosition:
              SnackPosition.BOTTOM, // Change to SnackPosition.BOTTOM for bottom
          backgroundColor: AppColor.teelColor, // Background color
          colorText: Colors.white, // Text color
          borderRadius: 10,
          snackStyle: SnackStyle.FLOATING, // Set the snack style to FLOATING
          margin: EdgeInsets
              .zero, // Remove margin to redu // BorderRadius for the snackbar
          duration: Duration(
              seconds: 3), // Duration for which the snackbar will be visible
        );
      }
    } catch (error) {
      print('Error during lawyer profile creation: $error');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    lawyerTypeController = SingleValueDropDownController();
    lawyerAboutController;
    lawyerEducationController;
    lawyerExperienceController;
  }
}
