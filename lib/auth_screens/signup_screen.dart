import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/screens/fill_profile_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SingleValueDropDownController _rolecontroller;
  @override
  void initState() {
    _rolecontroller = SingleValueDropDownController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Center(
                      child: Image.asset(
                    'assets/images/logo.png',
                    scale: 3.5,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                  child: Center(
                    child: Text(
                      '(Appname)',
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Create Account',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                  child: Center(
                    child: Text(
                      'We are here to help you!',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
                MyTextField(
                    hinttext: 'Full Name', icon: Icons.person_2_outlined),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.h),
                    child: DropDownTextField(
                      textFieldDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(17, 25, 40, 1)),
                              borderRadius: BorderRadius.circular(24)),
                          hintText: 'Select Role',
                          fillColor: Colors.grey[200],
                          filled: true),
                      clearOption: true,
                      controller: _rolecontroller,
                      validator: (value) {
                        if (value == null) {
                          return "Required field";
                        } else {
                          return null;
                        }
                      },
                      dropDownItemCount: 2,
                      dropDownList: const [
                        DropDownValueModel(name: 'Lawyer', value: "value1"),
                        DropDownValueModel(name: 'Client', value: "value2"),
                      ],
                      onChanged: (val) {},
                    )),
                MyTextField(hinttext: 'Email', icon: Icons.email_outlined),
                MyTextField(hinttext: 'Password', icon: Icons.lock_outline),
                SizedBox(
                  height: 15.h,
                ),
                RoundedButton(
                    text: 'Create Account',
                    onPressed: () {
                      Get.to(FillProfileScreen());
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do you have an account? ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color.fromRGBO(107, 114, 128, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
