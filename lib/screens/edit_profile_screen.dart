import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/edit_profile_controller.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/screens/blog_screen.dart';
import 'package:lawyerapp/screens/favorite_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  String profile;
  String name;
  String email;
  String phone;
  String accountType;
  EditProfileScreen({
    required this.profile,
    required this.email,
    required this.name,
    required this.phone,
    required this.accountType,
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileController editProfileController =
      Get.put(EditProfileController());
  // Method to pick image from the gallery

  final UserController controller = Get.put(UserController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String email = '';

  void check() {
    setState(() {
      nameController.text = widget.name;
      phoneController.text = widget.phone;
      email = widget.email;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editProfileController.accounttypeController = SingleValueDropDownController(
        data: DropDownValueModel(
            name: widget.accountType,
            value: widget.accountType == 'Company' ? 0 : 1));
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
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(widget.profile),
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
                                        editProfileController.pickImage(
                                          ImageSource.gallery,
                                        ); // Pick image from gallery
                                      },
                                      text: 'Pick from Gallery',
                                      Color: AppColor.teelColor,
                                    ),
                                    const SizedBox(height: 16),
                                    RoundedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                        editProfileController.pickImage(
                                          ImageSource.camera,
                                        ); // Pick image from camera
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Text(
                        'Account Type',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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
                        controller: editProfileController.accounttypeController,
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
                          setState(() {});
                        },
                        dropDownItemCount: 2,
                      ),
                    ),
                    //controller.accounttypeController.va
                    editProfileController.accounttypeController.dropDownValue ==
                            null
                        ? SizedBox()
                        : editProfileController.accounttypeController
                                    .dropDownValue!.name ==
                                'Company'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    child: Text(
                                      'Company Name',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  MyTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Company Name';
                                        }
                                        return null; // Return null if the validation passes
                                      },
                                      isicon2: false,
                                      controller: editProfileController
                                          .companyNameController,
                                      hinttext: 'Company Name',
                                      icon: Icons.person_2_outlined),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    child: Text(
                                      'Company Profession',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  MyTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Company Profession';
                                        }
                                        return null; // Return null if the validation passes
                                      },
                                      isicon2: false,
                                      controller: editProfileController
                                          .companyProfessionController,
                                      hinttext: 'Company Profession',
                                      icon: Icons.person_2_outlined),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    child: Text(
                                      'Company Location',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  MyTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Company Location';
                                        }
                                        return null; // Return null if the validation passes
                                      },
                                      isicon2: false,
                                      controller: editProfileController
                                          .companyLocationController,
                                      hinttext: 'Company Location',
                                      icon: Icons.person_2_outlined),
                                ],
                              )
                            : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                        text: 'Save',
                        onPressed: () {},
                        Color: AppColor.teelColor)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
