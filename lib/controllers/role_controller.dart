import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/screens/fill_profile_screen.dart';
import 'package:lawyerapp/screens/lawyer_detail_screen.dart';

class RoleController extends GetxController {
  RxInt selectedValue = RxInt(2);

  Future<void> updateRole(String email) async {
    final url = 'https://lawyer-app.azsolutionspk.com/api/user/update/role';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'role': selectedValue.value.toString(),
        },
      );

      final responseData = json.decode(response.body);

      if (responseData['status'] == 1) {
        // Role update successful
        print('Role update successful');
        print('Message: ${responseData['message']}');
        print(responseData['role']);
        print('Role: ${responseData['role']}');
        String role = responseData['role'];
        if (role == '1') {
          Get.to(FillProfileScreen(
            email: email,
          ));
        } else if (role == '2') {
          Get.offAll(LoginScreen());
        }
      } else {
        // Role update failed
        print('Role update failed');
        print('Message: ${responseData['message']}');
      }
    } catch (error) {
      print('Error during role update: $error');
    }
  }

  void selectImage(int value) {
    selectedValue.value = value;
  }
}
