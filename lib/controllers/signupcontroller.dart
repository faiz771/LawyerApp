import 'dart:convert';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  RxBool agreed = false.obs;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final nameController = TextEditingController();

  late SingleValueDropDownController accounttype;

  final phoneController = TextEditingController();

  Future<void> registerUser() async {
    const String apiUrl =
        'https://lawyer-app.azsolutionspk.com/api/user/register'; // Replace with your actual API endpoint

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passwordController.text,
        'account_type': accounttype.dropDownValue!.name,
        'password_confirmation': passwordController
            .text, // Assuming you have a password_confirmation field
      }),
    );

    if (response.statusCode == 200) {
      // User created successfully

      print('User created successfully');

      print(response.body);

      // You can handle the success response here
    } else {
      // Registration failed

      print('Registration failed');

      print(response.body);

      // You can handle the error response here
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();

    accounttype = SingleValueDropDownController();
  }
}
