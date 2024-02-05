// user_controller.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/models/user_detail_model.dart';
import 'package:lawyerapp/screens/client_homepage_screen.dart';
import 'package:lawyerapp/screens/lawyer_homepage_screen.dart';
import 'package:lawyerapp/screens/select_role_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';

class UserController extends GetxController {
  final String baseUrl = 'https://lawyer-app.azsolutionspk.com/api/user';

  Rx<UserModel?> user = Rx<UserModel?>(null);

  Future<void> getUserDetails() async {
    try {
      final SharedPreferencesService prefsService = SharedPreferencesService();
      final String? token = await prefsService.getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/user-detail'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == 1) {
          // User details fetched successfully
          final userDetail = UserModel.fromJson(responseData['data']);
          user.value = userDetail;

          // Check the role and print it
          print('User Role: ${userDetail.role}');
          if (userDetail.role == 0) {
            Get.to(SelectRoleScreen(email: userDetail.email));
          } else if (userDetail.role == 1) {
            Get.offAll(LawyerHomepage());
          } else if (userDetail.role == 2) {
            Get.offAll(ClientHomepage());
          }
        } else {
          // Handle the case where the API returns an error status
          clearPreferencesAndNavigateToLogin();
        }
      } else {
        // Handle non-200 status code
        clearPreferencesAndNavigateToLogin();
      }
    } catch (error) {
      // Handle other errors
      clearPreferencesAndNavigateToLogin();
    }
  }

  void clearPreferencesAndNavigateToLogin() {
    // Clear preferences logic here

    // Navigate to the login screen
    Get.offAll(LoginScreen()); // Assuming LoginScreen is your login page
  }
}
