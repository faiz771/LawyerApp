import 'dart:convert';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';

class LawyerProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController lawyerEducationController = TextEditingController();
  TextEditingController lawyerExperienceController = TextEditingController();
  TextEditingController lawyerAboutController = TextEditingController();
  late SingleValueDropDownController lawyerTypeController;

  Future<void> createLawyerProfile({
    required String email,
  }) async {
    const url =
        'https://lawyer-app.azsolutionspk.com/api/user/lawyer/profile/create';
    print('Api: $url');
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
      isLoading.value = false;
      if (responseData['status'] == 1) {
        // Profile creation successful
        print('Lawyer profile created successfully');
        print('Message: ${responseData['message']}');
        showStylishBottomToast(responseData['message'].toString());
        Get.offAll(const LoginScreen());
      } else {
        // Profile creation failed
        print('Lawyer profile creation failed');
        print('Message: ${responseData['message']}');
        isLoading.value = false;
        showStylishBottomToast(responseData['message'].toString());
      }
    } catch (error) {
      isLoading.value = false;
      print('Error during lawyer profile creation: $error');
      showStylishBottomToast(error.toString());
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
