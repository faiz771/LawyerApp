import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/login_controller.dart';
import 'package:lawyerapp/controllers/profile_setting_controller.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/models/user_detail_model.dart';
import 'package:lawyerapp/screens/edit_profile_screen.dart';
import 'package:lawyerapp/screens/favorite_screen.dart';
import 'package:lawyerapp/screens/settings.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColor.teelColor,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.profileSettingsTitle,
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
                title: Text(
                  AppLocalizations.of(context)!.editProfile,
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
                  AppLocalizations.of(context)!.favorite,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.favorite_outline,
                  color: Color.fromRGBO(17, 25, 40, 1),
                ),
                onTap: () {
                  Get.to(const FavoriteScreen());
                },
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
                title: Text(
                  AppLocalizations.of(context)!.settings,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.settings_outlined,
                  color: Color.fromRGBO(17, 25, 40, 1),
                ),
                onTap: () {
                  Get.to(SettingsScreen());
                },
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
                title: Text(
                  AppLocalizations.of(context)!.changePassword,
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
                  AppLocalizations.of(context)!.notifications,
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
                  AppLocalizations.of(context)!.aboutUs,
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
                  AppLocalizations.of(context)!.helpAndSupport,
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
                  AppLocalizations.of(context)!.logout,
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
                                Text(
                                  AppLocalizations.of(context)!.logout,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .logoutConfirmationMessage)),
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
                                  text: AppLocalizations.of(context)!.logout,
                                  onPressed: () {
                                    SharedPreferencesService().clearToken();
                                    Get.offAll(const LoginScreen());
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

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.changePassword,
                            style: const TextStyle(
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
                                return AppLocalizations.of(context)!
                                    .password_empty;
                              }
                              if (value.length < 8) {
                                return AppLocalizations.of(context)!
                                    .password_length;
                              }
                              // Add additional password strength checks as needed
                              // For example, you can check for the presence of uppercase letters, lowercase letters, numbers, and special characters

                              // Example: Check for lowercase letters
                              final hasLowercase =
                                  RegExp(r'[a-z]').hasMatch(value);
                              if (!hasLowercase) {
                                return AppLocalizations.of(context)!
                                    .lowercase_letters;
                              }

                              // Example: Check for uppercase letters
                              final hasUppercase =
                                  RegExp(r'[A-Z]').hasMatch(value);
                              if (!hasUppercase) {
                                return AppLocalizations.of(context)!
                                    .uppercase_letters;
                              }

                              // Example: Check for numbers
                              final hasNumber =
                                  RegExp(r'[0-9]').hasMatch(value);
                              if (!hasNumber) {
                                return AppLocalizations.of(context)!.numbers;
                              }

                              // Example: Check for special characters
                              final hasSpecialCharacters =
                                  RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                      .hasMatch(value);
                              if (!hasSpecialCharacters) {
                                return AppLocalizations.of(context)!
                                    .special_characters;
                              }
                              // if (controller.passwordController.value !=
                              //     controller.confirmPasswordController.value) {
                              //   return AppLocalizations.of(context)!
                              //       .password_match;
                              // }
                              // Password meets all criteria, so return null indicating validation passed
                              return null;
                            },
                            hinttext: AppLocalizations.of(context)!
                                .enter_new_password,
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
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(() => MyTextField(
                            controller: profileSettingController
                                .confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .password_empty;
                              }
                              if (value.length < 8) {
                                return AppLocalizations.of(context)!
                                    .password_length;
                              }
                              // Add additional password strength checks as needed
                              // For example, you can check for the presence of uppercase letters, lowercase letters, numbers, and special characters

                              // Example: Check for lowercase letters
                              final hasLowercase =
                                  RegExp(r'[a-z]').hasMatch(value);
                              if (!hasLowercase) {
                                return AppLocalizations.of(context)!
                                    .lowercase_letters;
                              }

                              // Example: Check for uppercase letters
                              final hasUppercase =
                                  RegExp(r'[A-Z]').hasMatch(value);
                              if (!hasUppercase) {
                                return AppLocalizations.of(context)!
                                    .uppercase_letters;
                              }

                              // Example: Check for numbers
                              final hasNumber =
                                  RegExp(r'[0-9]').hasMatch(value);
                              if (!hasNumber) {
                                return AppLocalizations.of(context)!.numbers;
                              }

                              // Example: Check for special characters
                              final hasSpecialCharacters =
                                  RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                      .hasMatch(value);
                              if (!hasSpecialCharacters) {
                                return AppLocalizations.of(context)!
                                    .special_characters;
                              }
                              if (profileSettingController
                                      .passwordController.value !=
                                  profileSettingController
                                      .confirmPasswordController.value) {
                                return AppLocalizations.of(context)!
                                    .password_match;
                              }
                              // Password meets all criteria, so return null indicating validation passed
                              return null;
                            },
                            hinttext:
                                AppLocalizations.of(context)!.confirm_password,
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
                        child: const SizedBox(height: 230),
                      ),
                      const SizedBox(height: 16),
                      Obx(() => profileSettingController.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColor.teelColor,
                              ),
                            )
                          : RoundedButton(
                              text: AppLocalizations.of(context)!.save_changes,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
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
