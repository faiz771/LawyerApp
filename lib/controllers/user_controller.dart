// user_controller.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/models/user_detail_model.dart';
import 'package:lawyerapp/screens/client_homepage_screen.dart';
import 'package:lawyerapp/screens/lawyer_homepage_screen.dart';
import 'package:lawyerapp/screens/select_role_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';

class UserController extends GetxController {
  final String baseUrl = 'https://lawyer-app.azsolutionspk.com/api/user';

  Rx<UserModel?> user = Rx<UserModel?>(null);

  Future<void> getUserDetails() async {
    print('Api: $baseUrl');
    try {
      final SharedPreferencesService prefsService = SharedPreferencesService();
      final String? token = await prefsService.getToken();
      if (token == null) {
        // Handle the case where token is null
        clearPreferencesAndNavigateToLogin();
        return;
      }
      print(token);
      final response = await http.get(
        Uri.parse('$baseUrl/user-detail'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Saved Token $token');
      print('status code ${response.statusCode}');
      print('Response ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Response Data: $responseData');
        print('status ${responseData['status']}');
        if (responseData['status'] == 1) {
          // Get.offAll(ClientHomepage());
          final userDetail = UserModel.fromJson(responseData['data']);
          print('User Role: ${userDetail.role}');

          // Handle different user roles and navigate accordingly
          if (userDetail.role == 0) {
            Get.to(SelectRoleScreen(email: userDetail.email));
          } else if (userDetail.role == 1) {
            Get.offAll(LawyerHomepage());
          } else if (userDetail.role == 2) {
            Get.offAll(ClientHomepage());
          }
        } else {
          // Handle error response
          clearPreferencesAndNavigateToLogin();
          showStylishBottomToast(responseData['message'].toString());
          print(responseData['message']);
        }
      } else {
        // Handle non-200 status code
        clearPreferencesAndNavigateToLogin();
        showStylishBottomToast('Failed to fetch user details');
      }
    } catch (error) {
      // Handle other errors
      clearPreferencesAndNavigateToLogin();
      showStylishBottomToast('Error: $error');
    }
  }

  void clearPreferencesAndNavigateToLogin() async {
    final SharedPreferencesService prefsService = SharedPreferencesService();
    await prefsService.clearToken();
    // Clear preferences logic here

    // Navigate to the login screen
    Get.offAll(LoginScreen()); // Assuming LoginScreen is your login page
  }
}
