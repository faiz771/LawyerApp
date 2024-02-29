import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/screens/blog_screen.dart';
import 'package:lawyerapp/screens/favorite_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String email = '';
  void check() {
    setState(() {
      nameController.text = controller.user.value!.name;
      phoneController.text = controller.user.value!.phone;
      email = controller.user.value!.email;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColor.teelColor,
          centerTitle: true,
          title: Text(
            'Edit Profile',
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
                height: 20.h,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    MyTextField(
                      hinttext: 'Name',
                      isicon2: false,
                      icon: Icons.person,
                      controller: nameController,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Text(
                        'Phone',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    MyTextField(
                      hinttext: 'Phone',
                      controller: phoneController,
                      isicon2: false,
                      icon: Icons.person,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.greyColor,
                          borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: Text(
                          email,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
