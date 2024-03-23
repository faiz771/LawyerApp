// user_controller.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/models/user_detail_model.dart';
import 'package:lawyerapp/screens/client_homepage_screen.dart';
import 'package:lawyerapp/screens/lawyer_homepage_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/api_base_url.dart';

class UserController extends GetxController {
  Rx<UserModel?> user = Rx<UserModel?>(null);

  Future<void> getUserDetails() async {
    final String url = '${Api.ApiBaseUrl}/user-detail';
    print('Api: $url');
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
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Saved Token $token');
      print('status code ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        //  String message = responseData['message'].join('\n');
        print('Response Data: $responseData');
        print('status ${responseData['status']}');
        if (responseData['status'] == 1) {
          // Get.offAll(ClientHomepage());
          final userDetail = UserModel.fromJson(responseData['data']);
          user.value = userDetail;
          print('User Role: ${userDetail.role}');
          // Handle different user roles and navigate accordingly
          update();
          if (userDetail.role == 1) {
            Get.offAll(LawyerHomepage(
              user: userDetail,
            ));
          } else if (userDetail.role == 0) {
            Get.offAll(ClientHomepage(
              user: userDetail,
            ));
          }
        } else {
          // Handle error response
          clearPreferencesAndNavigateToLogin();
          //   print(responseData['message']);
        }
      } else {
        // Handle non-200 status code
        clearPreferencesAndNavigateToLogin();
        print('Failed to fetch user details');
      }
    } catch (error) {
      // Handle other errors
      clearPreferencesAndNavigateToLogin();
      print('Error: $error');
    }
  }

  void clearPreferencesAndNavigateToLogin() async {
    final SharedPreferencesService prefsService = SharedPreferencesService();
    await prefsService.clearToken();
    // Clear preferences logic here

    // Navigate to the login screen
    Get.offAll(const LoginScreen()); // Assuming LoginScreen is your login page
  }
}
