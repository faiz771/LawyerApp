import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyProfessionController = TextEditingController();
  final companyLocationController = TextEditingController();

  late SingleValueDropDownController accounttypeController;

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
