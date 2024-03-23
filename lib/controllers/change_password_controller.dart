import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/utils/api_base_url.dart';

class ChangePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  Future<void> changePassword(
      String email, String password, String confirmPassword) async {
    String url = "${Api.ApiBaseUrl}/update/password";
    print('Api: $url');
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );

      final responseData = json.decode(response.body);
      String message = responseData['message'].join('\n');
      if (responseData['status'] == 1) {
        isLoading.value = false;
        // Password updated successfully
        print('Message $message');
        Get.offAll(LoginScreen());
        showStylishBottomToast(message);
        print('Password updated successfully');
      } else {
        isLoading.value = false;
        // Password update failed
        print('Message $message');
        showStylishBottomToast(message);
      }
    } catch (error) {
      isLoading.value = false;
      showStylishBottomToast('Error please try again');
      print('Error during password update: $error');
    }
  }
}
