import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/login_controller.dart';
import 'package:lawyerapp/controllers/profile_setting_controller.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/models/user_detail_model.dart';
import 'package:lawyerapp/screens/blog_screen.dart';
import 'package:lawyerapp/screens/edit_profile_screen.dart';
import 'package:lawyerapp/screens/favorite_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingScreen extends StatefulWidget {
  UserModel user;
  ProfileSettingScreen({super.key, required this.user});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final LoginController loginController = Get.put(LoginController());
  final UserController controller = Get.put(UserController());
  final ProfileSettingController profileSettingController =
      Get.put(ProfileSettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColor.teelColor,
          centerTitle: true,
          title: Text(
            'Profile Settings',
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 50.h,
              // ),
              // Center(
              //   child: Text(
              //     'Profile',
              //     style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              //   ),
              // ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(widget.user.profile_path!),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  widget.user.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
                title: Text(
                  'Edit Profile',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.edit_outlined,
                  color: Color.fromRGBO(17, 25, 40, 1),
                ),
                onTap: () {
                  Get.to(EditProfileScreen(
                    user: widget.user,
                    isLawyer: widget.user.role == 1 ? true : false,
                  ));
                },
              ),

              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
                title: Text(
                  'Favorite',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.favorite_outline,
                  color: Color.fromRGBO(17, 25, 40, 1),
                ),
                onTap: () {
                  Get.to(FavoriteScreen());
                },
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
                title: Text(
                  'Settings',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.settings_outlined,
                  color: Color.fromRGBO(17, 25, 40, 1),
                ),
                onTap: () {},
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
                title: Text(
                  'Change Password',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.lock_outline,
                  color: Color.fromRGBO(17, 25, 40, 1),
                ),
                onTap: () {
                  _showChangePassowrdBottomSheet(context);
                },
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
                title: Text(
                  'Notifications',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.notifications_outlined,
                  color: Color.fromRGBO(17, 25, 40, 1),
                ),
                onTap: () {},
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
                title: Text(
                  'About Us',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.info_outline,
                  color: Color.fromRGBO(17, 25, 40, 1),
                ),
                onTap: () {},
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
                title: Text(
                  'Help and Support',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.live_help_outlined,
                  color: Color.fromRGBO(17, 25, 40, 1),
                ),
                onTap: () {},
              ),
              // ListTile(
              //   trailing: Icon(
              //     Icons.arrow_forward_ios_sharp,
              //     size: 20,
              //   ),
              //   title: Text(
              //     'Terms And Conditions',
              //     style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              //   ),
              //   leading: Icon(
              //     Icons.policy_outlined,
              //     color: Color.fromRGBO(17, 25, 40, 1),
              //   ),
              //   onTap: () {},
              // ),
              ListTile(
                title: Text(
                  'Logout',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Color.fromRGBO(17, 25, 40, 1),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                const Center(
                                    child: Text(
                                        'Are you sure you want to logout')),
                                const SizedBox(height: 20),
                                // Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   children: [
                                // RoundedButton(
                                //   text: 'Cancel',
                                //   onPressed: () {},
                                // ),
                                RoundedButton(
                                  Color: AppColor.teelColor,
                                  text: 'Logout',
                                  onPressed: () {
                                    SharedPreferencesService().clearToken();
                                    Get.offAll(LoginScreen());
                                  },
                                )
                                //   ],
                                // )
                              ],
                            ),
                          );
                        });
                      });
                },
              )
            ],
          ),
        ));
  }

  void _showChangePassowrdBottomSheet(BuildContext context) {
    bool isKeyboardVisible = false;

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            MediaQuery.of(context).viewInsets.bottom > 0
                ? isKeyboardVisible = true
                : isKeyboardVisible = false;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Obx(() => MyTextField(
                            controller:
                                profileSettingController.passwordController,
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
                              final hasNumber =
                                  RegExp(r'[0-9]').hasMatch(value);
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
                            hinttext: 'Enter New Password',
                            //  controller: newPasswordController,
                            icon: Icons.lock,
                            isicon2: true,
                            icon2: loginController.passToggle.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onPressed: () {
                              loginController.passToggle.value =
                                  !loginController.passToggle.value;
                            },
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(() => MyTextField(
                            controller: profileSettingController
                                .confirmPasswordController,
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
                              final hasNumber =
                                  RegExp(r'[0-9]').hasMatch(value);
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
                              if (profileSettingController
                                      .passwordController.value !=
                                  profileSettingController
                                      .confirmPasswordController.value) {
                                return 'Password and Confirm Password must match.';
                              }
                              // Password meets all criteria, so return null indicating validation passed
                              return null;
                            },
                            hinttext: 'Confrim New Passowrd',
                            // controller: confirmPassowordController,
                            icon: Icons.lock, isicon2: true,
                            icon2: loginController.passToggle.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onPressed: () {
                              loginController.passToggle.value =
                                  !loginController.passToggle.value;
                            },
                          )),
                      Visibility(
                        visible: isKeyboardVisible,
                        child: SizedBox(height: 230),
                      ),
                      SizedBox(height: 16),
                      Obx(() => profileSettingController.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColor.teelColor,
                              ),
                            )
                          : RoundedButton(
                              text: 'Save Changes',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  profileSettingController.isLoading.value =
                                      true;
                                  await profileSettingController
                                      .changePassword();
                                  Navigator.pop(context);
                                }
                              },
                              Color: AppColor.teelColor,
                            ))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
