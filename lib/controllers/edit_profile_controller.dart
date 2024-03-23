import 'dart:convert';
import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/api_base_url.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyProfessionController = TextEditingController();
  final companyLocationController = TextEditingController();
  final lawyerExpController = TextEditingController();
  final lawyerEduController = TextEditingController();
  final lawyerFeeController = TextEditingController();
  final lawyerAboutController = TextEditingController();

  late SingleValueDropDownController accounttypeController;
  final UserController userController = Get.put(UserController());
  final phoneController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  RxBool isloading = false.obs;
  Rx<File?> imageFile = Rx<File?>(null);
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
        print("image ${imageFile.value!.path}");
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> updateProfile(File? imageFile, String countryCode) async {
    final SharedPreferencesService prefsService = SharedPreferencesService();
    final String? token = await prefsService.getToken();
    try {
      isloading.value = true;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Api.ApiBaseUrl}/profile/update'),
      );
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.fields['name'] = nameController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['country_code'] = countryCode;
      request.fields['account_type'] =
          accounttypeController.dropDownValue!.name;
      accounttypeController.dropDownValue!.name == 'Personal'
          ? null
          : request.fields['company_name'] = companyNameController.text;
      accounttypeController.dropDownValue!.name == 'Personal'
          ? null
          : request.fields['company_profession'] =
              companyProfessionController.text;
      accounttypeController.dropDownValue!.name == 'Personal'
          ? null
          : request.fields['company_address'] = companyLocationController.text;
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profile', imageFile.path),
        );
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      // Parse the response body JSON
      var jsonResponse = json.decode(responseBody);
      print(jsonResponse);
      var message = jsonResponse['message'][0];
      // Extract the message
      // var message = jsonResponse['message'];

      if (response.statusCode == 200) {
        showStylishBottomToast(message);
        isloading.value = false;
        await userController.getUserDetails();
        // settingsController.jumpToPages(0);
      } else {
        // DioClient.get().toAst(message);
        showStylishBottomToast(message);
        print('Failed to update profile. Status code: ${response.statusCode}');
        isloading.value = false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      showStylishBottomToast('Error please try again');
      isloading.value = false;
    }
  }

  Future<void> updateLawyerProfile(
      File? imageFile, String countryCode, int lawyerType) async {
    final SharedPreferencesService prefsService = SharedPreferencesService();
    final String? token = await prefsService.getToken();
    try {
      isloading.value = true;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Api.ApiBaseUrl}/lawyer/profile/update'),
      );
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.fields['name'] = nameController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['country_code'] = countryCode;
      request.fields['lawyer_type'] = lawyerType.toString();
      request.fields['lawyer_experience'] = lawyerExpController.text;
      request.fields['lawyer_education'] = lawyerEduController.text;
      request.fields['lawyer_about'] = lawyerAboutController.text;
      request.fields['lawyer_fees'] = lawyerFeeController.text;

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profile', imageFile.path),
        );
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print('Lawyer Type Before Sending $lawyerType');
      // Parse the response body JSON
      var jsonResponse = json.decode(responseBody);
      print(jsonResponse);
      var message = jsonResponse['message'][0];
      // Extract the message
      // var message = jsonResponse['message'];

      if (response.statusCode == 200) {
        showStylishBottomToast(message);
        isloading.value = false;
        await userController.getUserDetails();
        // settingsController.jumpToPages(0);
      } else {
        // DioClient.get().toAst(message);
        showStylishBottomToast(message);
        print('Failed to update profile. Status code: ${response.statusCode}');
        isloading.value = false;
      }
    } catch (e) {
      showStylishBottomToast('Error please try again');
      print('Error updating profile: $e');
      isloading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
