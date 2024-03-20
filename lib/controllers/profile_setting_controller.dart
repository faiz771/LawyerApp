import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/api_base_url.dart';

class ProfileSettingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool passToggle = false.obs;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  Future<void> changePassword() async {
    final SharedPreferencesService prefsService = SharedPreferencesService();
    final String? token = await prefsService.getToken();
    String url = "${Api.ApiBaseUrl}/change-password";
    print('Api: $url');
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );

      final responseData = json.decode(response.body);
      String message = responseData['message'].join('\n');
      if (responseData['status'] == 1) {
        isLoading.value = false;
        // Password updated successfully
        print('Message $message');
        // Get.offAll(LoginScreen());
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
      print('Error during password update: $error');
    }
  }
}
