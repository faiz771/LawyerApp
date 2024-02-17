import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/forget_password.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/forgot_password_controller.dart';
import 'package:lawyerapp/controllers/otp_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class VerifyOtpScreen extends StatefulWidget {
  String email = '';
  bool isFromForgot;
  VerifyOtpScreen({super.key, required this.email, required this.isFromForgot});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  VerifyOtpController verificationController = Get.put(VerifyOtpController());
  ForgotPasswordController forgotController =
      Get.put(ForgotPasswordController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
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
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Center(
                            child: Image.asset(
                          'assets/images/lawyerapp-logo.png',
                          scale: 3,
                        )),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                      //   child: Center(
                      //     child: Text(
                      //       'LawyerConnect',
                      //       style: TextStyle(
                      //         fontSize: 20.sp,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Center(
                        child: Text(
                          'Verify Code',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Center(
                          child: Text(
                            'Enter the the code we just sent you on your registered Email',
                            style: TextStyle(fontSize: 14.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                          (index) => SizedBox(
                            width: 50,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null; // Return null if the validation passes
                              },
                              style: const TextStyle(color: Colors.black),
                              controller:
                                  verificationController.optControllers[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: const EdgeInsets.all(12),
                                fillColor: Colors
                                    .white, // Replace with your desired color
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Obx(() => verificationController.isLoading.value
                          ? CircularProgressIndicator(
                              color: AppColor.teelColor,
                            )
                          : RoundedButton(
                              Color: AppColor.teelColor,
                              text: 'Verify',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (widget.isFromForgot == true) {
                                    verificationController.isLoading.value =
                                        true;
                                    verificationController
                                        .verifyForgotEmail(widget.email);
                                  } else if (widget.isFromForgot == false) {
                                    verificationController.isLoading.value =
                                        true;
                                    verificationController
                                        .verifyEmail(widget.email);
                                  }
                                }
                              })),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 20.h),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         'Didn\'t get the Code? ',
                      //         style: TextStyle(
                      //           fontSize: 14.sp,
                      //           color: const Color.fromRGBO(107, 114, 128, 1),
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //       InkWell(
                      //         onTap: () {
                      //           Get.to(const ForgetPasswordScreen());
                      //         },
                      //         child: Text(
                      //           'Resend',
                      //           style: TextStyle(
                      //               fontSize: 14.sp,
                      //               color: Colors.blue,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
