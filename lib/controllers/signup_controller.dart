import 'dart:convert';
import 'dart:ffi';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/auth_screens/verify_otp_screen.dart';

class SignUpController extends GetxController {
  RxBool agreed = false.obs;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final nameController = TextEditingController();

  late SingleValueDropDownController accounttypeController;

  final phoneController = TextEditingController();

  Future<void> signUp() async {
    final url = 'https://lawyer-app.azsolutionspk.com/api/user/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': nameController.text,
          'phone': phoneController.text,
          'account_type': accounttypeController.dropDownValue!.name,
          'email': emailController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
        },
      );

      final responseData = json.decode(response.body);

      if (responseData['status'] == 1) {
        // Successful signup
        print('Signup successful');
        print('Email: ${responseData['email']}');
        print('OTP: ${responseData['otp']}');
        print('Message: ${responseData['message']}');
        Get.to(VerifyOtpScreen(
          email: emailController.text,
        ));
      } else {
        // Signup failed
        print('Signup failed');
        print('Message: ${responseData['message']}');
      }
    } catch (error) {
      print('Error during signup: $error');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    accounttypeController = SingleValueDropDownController();
    nameController;
    passwordController;
    confirmPasswordController;
    emailController;
    phoneController;
  }
}
