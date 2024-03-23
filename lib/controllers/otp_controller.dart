import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/change_password_screen.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/utils/api_base_url.dart';

class VerifyOtpController extends GetxController {
  RxBool isLoading = false.obs;
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
    String url = '${Api.ApiBaseUrl}/opt/verification/$email';
    print('Api: $url');
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
      isLoading.value = false;
      String message = responseData['message'].join('\n');
      if (responseData['status'] == 1) {
        // OTP verification successful
        print('Email verification successful');
        print('Message: ${responseData['message']}');
        showStylishBottomToast(message);
        Get.to(const LoginScreen());
      } else {
        // OTP verification failed
        print('Email verification failed');
        print('Message: ${responseData['message']}');
        isLoading.value = false;
        showStylishBottomToast(message);
      }
    } catch (error) {
      isLoading.value = false;
      showStylishBottomToast('Error please try again');
      print('Error during email verification: $error');
    }
  }

  Future<void> verifyForgotEmail(
    String email,
  ) async {
    final String optNumbers = getNumbers().join();
    print('otpnumbers: $optNumbers');
    String url = '${Api.ApiBaseUrl}/opt/verification/$email';
    print('Api: $url');
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
      isLoading.value = false;
      String message = responseData['message'].join('\n');
      if (responseData['status'] == 1) {
        // OTP verification successful
        print('Email verification successful');
        print('Message: ${responseData['message']}');
        showStylishBottomToast(message);
        Get.to(ChangePasswordScreen(
          email: email,
        ));
      } else {
        // OTP verification failed
        print('Email verification failed');
        print('Message: ${responseData['message']}');
        isLoading.value = false;
        showStylishBottomToast(message);
      }
    } catch (error) {
      isLoading.value = false;
      showStylishBottomToast('Error please try again');
      print('Error during email verification: $error');
    }
  }
}
