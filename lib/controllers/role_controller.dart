import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/screens/fill_profile_screen.dart';

class RoleController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt selectedValue = RxInt(2);

  Future<void> updateRole(String email) async {
    const url = 'https://lawyer-app.azsolutionspk.com/api/user/update/role';
    print('Api: $url');
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'role': selectedValue.value.toString(),
        },
      );

      final responseData = json.decode(response.body);
      isLoading.value = false;
      if (responseData['status'] == 1) {
        // Role update successful
        print('Role update successful');
        print('Message: ${responseData['message']}');
        print(responseData['role']);
        print('Role: ${responseData['role']}');
        String role = responseData['role'];
        showStylishBottomToast(responseData['message'].toString());
        if (role == '1') {
          Get.to(FillProfileScreen(
            email: email,
          ));
        } else if (role == '2') {
          Get.offAll(const LoginScreen());
        }
      } else {
        // Role update failed
        print('Role update failed');
        print('Message: ${responseData['message']}');
        isLoading.value = false;
        showStylishBottomToast(responseData['message'].toString());
      }
    } catch (error) {
      isLoading.value = false;
      print('Error during role update: $error');
      showStylishBottomToast(error.toString());
    }
  }

  void selectImage(int value) {
    selectedValue.value = value;
  }
}
