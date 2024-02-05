import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/screens/client_homepage_screen.dart';
import 'package:lawyerapp/screens/lawyer_homepage_screen.dart';
import 'package:lawyerapp/screens/select_role_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  Future<void> login() async {
    final url = 'https://lawyer-app.azsolutionspk.com/api/user/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      final responseData = json.decode(response.body);

      if (responseData['status'] == 1) {
        // Login successful
        String token = responseData['token'];
        int role = responseData['role'];

        print('Login successful');
        print('Token: $token');
        print('Role: $role');
        if (role == 0) {
          Get.to(SelectRoleScreen(
            email: emailController.text,
          ));
        } else if (role == 1) {
          Get.offAll(LawyerHomepage());
        } else if (role == 2) {
          Get.offAll(ClientHomepage());
        }
        // Save the token in SharedPreferences
        await sharedPreferencesService.saveToken(token);

        // You can handle token and role as needed (e.g., navigate to another screen)
      } else {
        // Login failed
        print('Login failed');
        print('Message: ${responseData['message']}');
      }
    } catch (error) {
      print('Error during login: $error');
    }
  }
}
