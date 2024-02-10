import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/screens/client_homepage_screen.dart';
import 'package:lawyerapp/screens/lawyer_homepage_screen.dart';
import 'package:lawyerapp/screens/select_role_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool passToggle = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  Future<void> login() async {
    const url = 'https://lawyer-app.azsolutionspk.com/api/user/login';
    print('Api: $url');
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      final responseData = json.decode(response.body);
      isLoading.value = false;
      if (responseData['status'] == 1) {
        // Login successful
        String token = responseData['token'];
        int role = responseData['role'];

        print('Login successful');
        print('Token: $token');
        print('Role: $role');
        await sharedPreferencesService.saveToken(token);
        showStylishBottomToast(responseData['message'].toString());
        if (role == 0) {
          Get.to(SelectRoleScreen(
            email: emailController.text,
          ));
        } else if (role == 1) {
          Get.offAll(const LawyerHomepage());
        } else if (role == 2) {
          Get.offAll(const ClientHomepage());
        }
        // Save the token in SharedPreferences
        String? receivedToken = await sharedPreferencesService.getToken();
        print('Received Toke $receivedToken');
        // You can handle token and role as needed (e.g., navigate to another screen)
      } else {
        // Login failed
        print('Login failed');
        print('Message: ${responseData['message']}');
        isLoading.value = false;
        showStylishBottomToast(responseData['message'].toString());
        // Get.snackbar(
        //   '',
        //   responseData['message'].toString(), // Message
        //   snackPosition:
        //       SnackPosition.BOTTOM, // Change to SnackPosition.BOTTOM for bottom
        //   backgroundColor: AppColor.teelColor, // Background color
        //   colorText: Colors.white, // Text color
        //   borderRadius: 10,
        //   snackStyle: SnackStyle.FLOATING, // Set the snack style to FLOATING
        //   margin: EdgeInsets
        //       .zero, // Remove margin to redu // BorderRadius for the snackbar
        //   duration: Duration(
        //       seconds: 3), // Duration for which the snackbar will be visible
        // );
      }
    } catch (error) {
      isLoading.value = false;
      print('Error during login: $error');
      showStylishBottomToast(error.toString());
    }
  }
}
