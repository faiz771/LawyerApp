import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/api_base_url.dart';

class ConsultationController extends GetxController {
  final TextEditingController descriptionController = TextEditingController();
  RxBool agreed = false.obs;
  Rx<File?> imageFile = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();
  RxBool isloading = false.obs;
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

  RxString _selectedPDF = ''.obs;

  String get selectedPDF => _selectedPDF.value;

  Future<void> pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        _selectedPDF.value = result.files.single.path!;
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // Handle errors
      print('Error picking PDF: $e');
    }
  }

  Future<void> bookConsultation({
    required int consultationType,
    required int countryId,
    required String filePath,
  }) async {
    final url = '${Api.ApiBaseUrl}/consulation/store';
    final SharedPreferencesService prefsService = SharedPreferencesService();
    final String? token = await prefsService.getToken();
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json';

      request.fields['consultation_type'] = consultationType.toString();
      request.fields['country_id'] = countryId.toString();
      request.fields['description'] = descriptionController.text;

      // Adding file
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 1) {
          // Consultation added successfully
          print(jsonResponse['message'][0]);
          String message = jsonResponse['message'][0];
          isloading.value = false;
          showStylishBottomToast(message);
        } else {
          // Error occurred
          print(jsonResponse['message'][0]);
          String message = jsonResponse['message'][0];
          isloading.value = false;
          showStylishBottomToast(message);
        }
      } else {
        // Handle HTTP error
        print('Failed to add consultation. HTTP Error: ${response.statusCode}');
        showStylishBottomToast('Something went wrong please try again');
        isloading.value = false;
      }
    } catch (e) {
      // Handle other errors
      print('Failed to add consultation. Error: $e');
      isloading.value = false;
    }
  }
}
