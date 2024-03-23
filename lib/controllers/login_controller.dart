import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/models/user_detail_model.dart';
import 'package:lawyerapp/screens/client_homepage_screen.dart';
import 'package:lawyerapp/screens/lawyer_homepage_screen.dart';
import 'package:lawyerapp/screens/select_role_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/api_base_url.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool passToggle = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  Future<void> login() async {
    String url = "${Api.ApiBaseUrl}/login";
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

      String message = responseData['message'].join('\n');
      if (responseData['status'] == 1) {
        // Login successful
        String token = responseData['token'];
        int role = responseData['role'];

        print('Login successful');
        print('Token: $token');
        print('Role: $role');
        await sharedPreferencesService.saveToken(token);
        showStylishBottomToast(message);
        final userDetail = UserModel.fromJson(responseData['data']);
        user.value = userDetail;
        print('yeh hai user detail after the loginR ${user.value!.name}');

        if (role == 1) {
          Get.offAll(LawyerHomepage(
            user: userDetail,
          ));
        } else if (role == 0) {
          Get.offAll(ClientHomepage(
            user: userDetail,
          ));
        }
        // Save the token in SharedPreferences
        String? receivedToken = await sharedPreferencesService.getToken();
        print('Received Toke $receivedToken');
        // You can handle token and role as needed (e.g., navigate to another screen)
      } else {
        // Login failed
        print('Login failed');
        print('Message: $message');
        isLoading.value = false;
        showStylishBottomToast(message);
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
      showStylishBottomToast('Error please try again');
      print('Error during login: $error');
    }
  }

  Rx<UserModel?> user = Rx<UserModel?>(null);
  // Future<void> getUserDetails() async {
  //   final String url = '${Api.ApiBaseUrl}/user-detail';
  //   print('Api: $url');
  //   try {
  //     final SharedPreferencesService prefsService = SharedPreferencesService();
  //     final String? token = await prefsService.getToken();
  //     if (token == null) {
  //       // Handle the case where token is null
  //       // clearPreferencesAndNavigateToLogin();
  //       return;
  //     }
  //     print(token);
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     print('Saved Token $token');
  //     print('status code ${response.statusCode}');

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       String message = responseData['message'].join('\n');
  //       print('Response Data: $responseData');
  //       print('status ${responseData['status']}');
  //       if (responseData['status'] == 1) {
  //         // Get.offAll(ClientHomepage());
  //         final userDetail = UserModel.fromJson(responseData['data']);
  //         user.value = userDetail;
  //         print('User Role: ${userDetail.role}');
  //         // Handle different user roles and navigate accordingly
  //         // if (userDetail.role == 1) {
  //         //   Get.offAll(const LawyerHomepage());
  //         // } else if (userDetail.role == 0) {
  //         //   Get.offAll(const ClientHomepage());
  //         // }
  //       } else {
  //         // Handle error response

  //         print(responseData['message']);
  //       }
  //     } else {
  //       // Handle non-200 status code
  //     }
  //   } catch (error) {
  //     // Handle other errors

  //     print('Error: $error');
  //   }
//  }
}
