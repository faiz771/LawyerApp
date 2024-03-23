import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/auth_screens/verify_otp_screen.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/utils/api_base_url.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  Future<void> sendForgotEmail(String email) async {
    String url = '${Api.ApiBaseUrl}/forget/password';
    print('Api Url $url');
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'email': email},
      );

      final responseData = json.decode(response.body);
      String message = responseData['message'].join('\n');
      if (responseData['status'] == 1) {
        isLoading.value = false;
        // Email sent successfully
        final otp = responseData['otp'];
        print('Otp $otp');
        showStylishBottomToast(message);
        print('message $message');
        Get.to(
            VerifyOtpScreen(email: emailController.text, isFromForgot: true));
      } else {
        // Failed to send email
        isLoading.value = false;
        print('message $message');
        showStylishBottomToast(message);
      }
    } catch (error) {
      isLoading.value = false;
      showStylishBottomToast('Error please try again');
      print('Error ${error.toString()}');
      // Error sending request
    }
  }
}
