import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField(
      {super.key,
      this.controller,
      required this.hinttext,
      required this.icon,
      this.icon2});
  final TextEditingController? controller;
  final IconData icon;
  final IconData? icon2;
  String hinttext = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: TextField(
        minLines: 1,
        maxLines: 4,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 10.h),
            prefixIcon: Icon(icon),
            suffixIcon: Icon(icon2),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(24),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromRGBO(17, 25, 40, 1)),
                borderRadius: BorderRadius.circular(24)),
            hintText: hinttext,
            fillColor: Colors.grey[200],
            filled: true),
      ),
    );
  }
}
