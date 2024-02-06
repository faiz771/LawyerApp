import 'dart:convert';
import 'dart:ffi';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/auth_screens/verify_otp_screen.dart';
import 'package:lawyerapp/utils/app_colors.dart';

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
        Get.to(VerifyOtpScreen(
          email: emailController.text,
        ));
      } else {
        // Signup failed
        print('Signup failed');
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

// void showStylishBottomToast(msg) {
//   Fluttertoast.showToast(
//     msg: msg,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 2,
//     backgroundColor: Colors.blue,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }
