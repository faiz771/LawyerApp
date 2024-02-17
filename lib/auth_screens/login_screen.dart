import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/forget_password.dart';
import 'package:lawyerapp/auth_screens/signup_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/login_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.emailController.clear();
    controller.passwordController.clear();
  }

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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    // Padding(
                    //   padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    //   child: Center(
                    //     child: Text(
                    //       'Hope you\'re doing fine.',
                    //       style: TextStyle(fontSize: 14.sp),
                    //     ),
                    //   ),
                    // ),
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
                      hinttext: 'Your Email',
                      icon: Icons.email_outlined,
                    ),
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

                            // Password meets all criteria, so return null indicating validation passed
                            return null;
                          },
                          isicon2: true,
                          onPressed: () {
                            controller.passToggle.value =
                                !controller.passToggle.value;
                          },
                          icon2: controller.passToggle.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          controller: controller.passwordController,
                          hinttext: 'Password',
                          icon: Icons.lock_outline,
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    Obx(() => controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: AppColor.teelColor,
                          )
                        : RoundedButton(
                            Color: AppColor.teelColor,
                            text: 'Sign In',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Validation passed, perform sign-up
                                // For demo, just print the email and password
                                controller.isLoading.value = true;
                                controller.login();
                              }
                            })),
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: InkWell(
                        onTap: () {
                          Get.to(ForgetPasswordScreen());
                        },
                        child: Text(
                          'Forget password?',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account yet? ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color.fromRGBO(107, 114, 128, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(const SignUpScreen());
                            },
                            child: Text(
                              'Sign Up',
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
