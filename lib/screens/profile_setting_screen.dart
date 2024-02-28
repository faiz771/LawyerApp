import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/screens/blog_screen.dart';
import 'package:lawyerapp/screens/favorite_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingScreen extends StatefulWidget {
  String name;
  ProfileSettingScreen({super.key, required this.name});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  // Method to pick image from the gallery
  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    // Do something with the picked image
  }

  // Method to pick image from the camera
  Future<void> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    // Do something with the picked image
  }

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Profile Settings',
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
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
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        'assets/images/onboard2.jpg',
                      ),
                    ),
                    Positioned(
                      bottom: 15.h,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RoundedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                        _pickImageFromGallery(); // Pick image from gallery
                                      },
                                      text: 'Pick from Gallery',
                                      Color: AppColor.teelColor,
                                    ),
                                    const SizedBox(height: 16),
                                    RoundedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                        _pickImageFromCamera(); // Pick image from camera
                                      },
                                      text: 'Take a Photo',
                                      Color: AppColor.teelColor,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  widget.name,
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
                onTap: () {},
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
}
