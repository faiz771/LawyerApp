import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/login_controller.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/main.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String completeNumber = '';
  final SignUpController controller = Get.put(SignUpController());

  late SingleValueDropDownController _rolecontroller;
  final LoginController loginController = Get.put(LoginController());
  String selectedValue = 'Option 1';
  @override
  void initState() {
    _rolecontroller = SingleValueDropDownController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                      child: Center(
                          child: Image.asset(
                        'assets/images/lawyerapp-logo.png',
                        scale: 3,
                      )),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    //   child: Center(
                    //     child: Text(
                    //       'LawyerConnect',
                    //       style: TextStyle(
                    //           fontSize: 20.sp, fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),
                    Center(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    //   child: Center(
                    //     child: Text(
                    //       'We are here to help you!',
                    //       style: TextStyle(fontSize: 14.sp),
                    //     ),
                    //   ),
                    // ),
                    MyTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                          return null; // Return null if the validation passes
                        },
                        isicon2: false,
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
                      height: 5.h,
                    ),
                    IntlPhoneField(
                      //  key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (phoneNumber) {
                        if (controller.phoneController.text.isEmpty) {
                          return 'Phone number cannot be empty';
                        }
                        return null; // Return null if the validation passes
                      },
                      disableLengthCheck: true,
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        size: 28,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText: 'Phone',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10.h),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(17, 25, 40, 1)),
                            borderRadius: BorderRadius.circular(24)),
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
                        errorStyle: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (phone) {
                        completeNumber = phone.completeNumber;
                      },
                    ),

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
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: DropDownTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Select Account Type';
                          }
                          return null;
                        } // Return null if the validation passes
                        ,
                        controller: controller.accounttypeController,
                        textFieldDecoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Account Type',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10.h),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(17, 25, 40, 1)),
                              borderRadius: BorderRadius.circular(24)),
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
                          errorStyle: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        dropDownList: const [
                          DropDownValueModel(
                            name: "Company",
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          // Regular expression for email validation
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Invalid email format';
                          }
                          return null; // Return null if the validation passes
                        },
                        isicon2: false,
                        controller: controller.emailController,
                        hinttext: 'Email',
                        icon: Icons.email_outlined),
                    Obx(() => MyTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            // Add additional password strength checks as needed
                            // For example, you can check for the presence of uppercase letters, lowercase letters, numbers, and special characters

                            // Example: Check for lowercase letters
                            final hasLowercase =
                                RegExp(r'[a-z]').hasMatch(value);
                            if (!hasLowercase) {
                              return 'Password must contain lowercase letters';
                            }

                            // Example: Check for uppercase letters
                            final hasUppercase =
                                RegExp(r'[A-Z]').hasMatch(value);
                            if (!hasUppercase) {
                              return 'Password must contain uppercase letters';
                            }

                            // Example: Check for numbers
                            final hasNumber = RegExp(r'[0-9]').hasMatch(value);
                            if (!hasNumber) {
                              return 'Password must contain numbers';
                            }

                            // Example: Check for special characters
                            final hasSpecialCharacters =
                                RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                    .hasMatch(value);
                            if (!hasSpecialCharacters) {
                              return 'Password must contain special characters';
                            }
                            // if (controller.passwordController.value !=
                            //     controller.confirmPasswordController.value) {
                            //   return 'Password and Confirm Password must match.';
                            // }
                            // Password meets all criteria, so return null indicating validation passed
                            return null;
                          },
                          isicon2: true,
                          onPressed: () {
                            loginController.passToggle.value =
                                !loginController.passToggle.value;
                          },
                          icon2: loginController.passToggle.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          controller: controller.passwordController,
                          hinttext: 'Password',
                          icon: Icons.lock_outline,
                        )),

                    Obx(() => MyTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            // Add additional password strength checks as needed
                            // For example, you can check for the presence of uppercase letters, lowercase letters, numbers, and special characters

                            // Example: Check for lowercase letters
                            final hasLowercase =
                                RegExp(r'[a-z]').hasMatch(value);
                            if (!hasLowercase) {
                              return 'Password must contain lowercase letters';
                            }

                            // Example: Check for uppercase letters
                            final hasUppercase =
                                RegExp(r'[A-Z]').hasMatch(value);
                            if (!hasUppercase) {
                              return 'Password must contain uppercase letters';
                            }

                            // Example: Check for numbers
                            final hasNumber = RegExp(r'[0-9]').hasMatch(value);
                            if (!hasNumber) {
                              return 'Password must contain numbers';
                            }

                            // Example: Check for special characters
                            final hasSpecialCharacters =
                                RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                    .hasMatch(value);
                            if (!hasSpecialCharacters) {
                              return 'Password must contain special characters';
                            }
                            if (controller.passwordController.value !=
                                controller.confirmPasswordController.value) {
                              return 'Password and Confirm Password must match.';
                            }
                            // Password meets all criteria, so return null indicating validation passed
                            return null;
                          },
                          isicon2: true,
                          onPressed: () {
                            loginController.passToggle.value =
                                !loginController.passToggle.value;
                          },
                          icon2: loginController.passToggle.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          controller: controller.confirmPasswordController,
                          hinttext: 'Confirm Password',
                          icon: Icons.lock_outline,
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    // SizedBox(
                    //  height: 15.h,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              controller.agreed.value =
                                  !controller.agreed.value;
                            },
                            child: Obx(
                              () => Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.agreed.value
                                      ? AppColor.teelColor
                                      : Colors.white,
                                  border: Border.all(
                                    color: AppColor.teelColor,
                                    width: 2.0,
                                  ),
                                ),
                                child: Center(
                                  child: controller.agreed.value
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 12,
                                        )
                                      : null,
                                ),
                              ),
                            )),
                        const SizedBox(width: 10),
                        const Text(
                          'Agree to Terms & Conditions',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? CircularProgressIndicator(
                              color: AppColor.teelColor,
                            )
                          : RoundedButton(
                              Color: controller.agreed.value
                                  ? AppColor.teelColor
                                  : AppColor.greyColor,
                              text: 'Create Account',
                              onPressed: controller.agreed.value
                                  ? () {
                                      if (_formKey.currentState!.validate() &&
                                          controller.phoneController.text
                                              .isNotEmpty) {
                                        controller.isLoading.value = true;
                                        controller.phoneController.text =
                                            completeNumber;

                                        controller.signUp();
                                        // print(object)
                                        // Get.to(const SelectUserTypeScreen());
                                      }
                                    }
                                  : () {}),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Do you have an account? ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color.fromRGBO(107, 114, 128, 1),
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
        ),
      ),
    );
  }
}
