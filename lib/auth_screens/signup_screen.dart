import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/signupcontroller.dart';
import 'package:lawyerapp/screens/select_user_type.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = Get.put(SignUpController());

  late SingleValueDropDownController _rolecontroller;
  String selectedValue = 'Option 1';
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
                    controller: controller.nameController,
                    hinttext: 'Full Name',
                    icon: Icons.person_2_outlined),
                // Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 3.h),
                //     child: DropDownTextField(
                //       textFieldDecoration: InputDecoration(
                //           enabledBorder: OutlineInputBorder(
                //             borderSide: const BorderSide(color: Colors.white),
                //             borderRadius: BorderRadius.circular(24),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //               borderSide: const BorderSide(
                //                   color: Color.fromRGBO(17, 25, 40, 1)),
                //               borderRadius: BorderRadius.circular(24)),
                //           hintText: 'Select Role',
                //           fillColor: Colors.grey[200],
                //           filled: true),
                //       clearOption: true,
                //       controller: _rolecontroller,
                //       validator: (value) {
                //         if (value == null) {
                //           return "Required field";
                //         } else {
                //           return null;
                //         }
                //       },
                //       dropDownItemCount: 2,
                //       dropDownList: const [
                //         DropDownValueModel(name: 'Lawyer', value: "value1"),
                //         DropDownValueModel(name: 'Client', value: "value2"),
                //       ],
                //       onChanged: (val) {},
                //     )),
                SizedBox(
                  height: 10.h,
                ),
                IntlPhoneField(
                    disableLengthCheck: true,
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    //focusNode: FocusNode(),
                    dropdownIcon: Icon(
                      Icons.arrow_drop_down,
                      size: 28,
                    ),
                    decoration: InputDecoration(
                        // enabledBorder: InputBorder.none,

                        // disabledBorder: InputBorder.none,
                        // // enabledBorder: InputBorder.none,
                        // focusedBorder: InputBorder.none,
                        fillColor: Colors.grey[200],
                        filled: true,
                        labelText: "Phone Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide()))),

                // DropDownTextField(dropDownList: const [
                //   DropDownValueModel(
                //     name: "company",
                //     value: 0,
                //   ),
                //   DropDownValueModel(name: "personal", value: "company"),
                // ]),
                // DropdownButton<String>(
                //   value: selectedValue,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedValue = newValue!;
                //       print('Selected value: $selectedValue');
                //     });
                //   },
                //   items: <String>['Option 1', 'Option 2']
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DropDownTextField(
                    controller: controller.accounttype,
                    textFieldDecoration: InputDecoration(
                      hintText: "Select Account ",
                      fillColor: Colors.grey[200],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    dropDownList: const [
                      DropDownValueModel(
                        name: "company",
                        value: 0,
                      ),
                      DropDownValueModel(name: "Personal", value: 1),
                    ],
                    onChanged: (selectedValue) {
                      print("$selectedValue");
                    },
                    dropDownItemCount: 2,
                  ),
                ),
                MyTextField(
                    controller: controller.emailController,
                    hinttext: 'Email',
                    icon: Icons.email_outlined),
                MyTextField(
                    controller: controller.passwordController,
                    hinttext: 'Password',
                    icon: Icons.lock_outline),

                MyTextField(
                    controller: controller.confirmPasswordController,
                    hinttext: 'Confirm Password',
                    icon: Icons.lock_outline),
                SizedBox(
                  height: 15.h,
                ),
                // SizedBox(
                //  height: 15.h,
                // ),

                RoundedButton(
                    text: 'Create Account',
                    onPressed: () {
                      Get.to(SelectUserTypeScreen());
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
