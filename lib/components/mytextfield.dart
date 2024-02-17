import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/login_controller.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    this.controller,
    required this.hinttext,
    required this.icon,
    this.onPressed,
    required this.isicon2,
    this.icon2,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final IconData icon;
  final IconData? icon2;
  final bool isicon2;
  final String hinttext;
  final VoidCallback? onPressed;
  final String? Function(String?)? validator;
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: TextFormField(
        controller: controller,
        obscureText: isicon2 ? loginController.passToggle.value : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 10.h),
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(icon2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromRGBO(17, 25, 40, 1)),
            borderRadius: BorderRadius.circular(24),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(24),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          hintText: hinttext,
          fillColor: Colors.grey[200],
          filled: true,
        ),
        validator: validator,
      ),
    );
  }
}
