import 'dart:convert';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/auth_screens/verify_otp_screen.dart';
import 'package:lawyerapp/utils/api_base_url.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class SignUpController extends GetxController {
  RxBool agreed = false.obs;
  RxBool isLoading = false.obs;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final nameController = TextEditingController();

  late SingleValueDropDownController accounttypeController;

  final phoneController = TextEditingController();

  Future<void> signUp() async {
    String url = "${Api.ApiBaseUrl}/register";
    print('Api: $url');
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
      isLoading.value = false;
      String message = responseData['message'].join('\n');
      if (responseData['status'] == 1) {
        // Successful signup
        print('Signup successful');
        print('Email: ${responseData['email']}');
        print('OTP: ${responseData['otp']}');
        print('Message: $message');
        showStylishBottomToast(message);
        Get.to(VerifyOtpScreen(
          email: emailController.text,
          isFromForgot: false,
        ));
      } else {
        // Signup failed
        isLoading.value = false;
        print('Signup failed');
        print('Message: $message');
        showStylishBottomToast(message);
      }
    } catch (error) {
      isLoading.value = false;
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.clear();

    passwordController.clear();

    confirmPasswordController.clear();

    nameController.clear();
    accounttypeController.clearDropDown();

    phoneController.clear();
  }
}

void showStylishBottomToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: AppColor.teelColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
