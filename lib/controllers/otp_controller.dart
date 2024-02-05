import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/screens/select_role_screen.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class VerifyOtpController extends GetxController {
  List<TextEditingController> optControllers =
      List.generate(6, (index) => TextEditingController());

  List<String> getNumbers() {
    return optControllers.map((controller) => controller.text).toList();
  }

  Future<void> verifyEmail(
    String email,
  ) async {
    final String optNumbers = getNumbers().join();
    print('otpnumbers: $optNumbers');
    final url =
        'https://lawyer-app.azsolutionspk.com/api/user/opt/verification/$email';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'otp': optNumbers,
        },
      );

      final responseData = json.decode(response.body);
      print(responseData['status']);
      if (responseData['status'] == 1) {
        // OTP verification successful
        print('Email verification successful');
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
        Get.to(SelectRoleScreen(
          email: email,
        ));
      } else {
        // OTP verification failed
        print('Email verification failed');
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
      print('Error during email verification: $error');
    }
  }
}
