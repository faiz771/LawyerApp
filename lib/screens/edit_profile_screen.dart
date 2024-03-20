import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/edit_profile_controller.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/models/user_detail_model.dart';
import 'package:lawyerapp/screens/blog_screen.dart';
import 'package:lawyerapp/screens/favorite_screen.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/api_base_url.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  UserModel user;
  bool isLawyer;
  EditProfileScreen({
    required this.user,
    required this.isLawyer,
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
  String email = '';
  RxString countrycode = ''.obs;
  void check() {
    setState(() {
      editProfileController.nameController.text = widget.user.name;
      editProfileController.phoneController.text = widget.user.phone;
      if (!widget.isLawyer) {
        editProfileController.companyNameController.text =
            widget.user.companyName!;
        editProfileController.companyLocationController.text =
            widget.user.companyAddress!;
        editProfileController.companyProfessionController.text =
            widget.user.company_profession!;
      }
      email = widget.user.email;

      countrycode.value = widget.user.countryCode!;
    });
  }

  List<String> categoryNames = [];
  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('${Api.ApiBaseUrl}/lawyer/categories'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> categories = jsonData['data'];
        List<String> names = (categories as List<dynamic>)
            .map<String>((category) => category['category_name'] as String)
            .toList();
        setState(() {
          categoryNames = names;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isLawyer
        ? editProfileController.accounttypeController =
            SingleValueDropDownController()
        : editProfileController.accounttypeController =
            SingleValueDropDownController(
                data: DropDownValueModel(
                    name: widget.user.accountType!,
                    value: widget.user.accountType! == 'Company' ? 0 : 1));
    check();
    fetchCategories();
  }

  var consultationType;
  var caseDescription;
  var country;
  bool isConsultationTypeFilled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        backgroundImage:
                            NetworkImage(widget.user.profile_path!),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                          return null; // Return null if the validation passes
                        },
                        hinttext: 'Name',
                        isicon2: false,
                        icon: Icons.person,
                        controller: editProfileController.nameController,
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
                      IntlPhoneField(
                        initialCountryCode: countrycode.value,

                        //  key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (phoneNumber) {
                          if (editProfileController
                              .phoneController.text.isEmpty) {
                            return 'Phone number cannot be empty';
                          }
                          return null; // Return null if the validation passes
                        },
                        disableLengthCheck: true,
                        controller: editProfileController.phoneController,
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
                          print(phone.countryCode);
                          setState(() {
                            countrycode.value = phone.countryISOCode;
                          });
                          // setState(() {
                          //   countrycode = phone.countryCode.tr;
                          // });
                        },
                        onSaved: (phone) {
                          setState(() {
                            countrycode.value = phone!.countryISOCode;
                          });
                          // setState(() {
                          //   countrycode = phone.countryCode.tr;
                          // });
                        },
                        onCountryChanged: (phone) {
                          setState(() {
                            countrycode.value = phone.code!;
                          });
                        },
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
                      widget.isLawyer
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              child: Text(
                                'Account Type',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                      widget.isLawyer
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: DropDownTextField(
                                clearOption: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Select Account Type';
                                  }
                                  return null;
                                } // Return null if the validation passes
                                ,
                                controller:
                                    editProfileController.accounttypeController,
                                textFieldDecoration: InputDecoration(
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  hintText: 'Account Type',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10.h),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(17, 25, 40, 1)),
                                      borderRadius: BorderRadius.circular(24)),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                dropDownList: const [
                                  DropDownValueModel(
                                    name: "Company",
                                    value: 0,
                                  ),
                                  DropDownValueModel(
                                      name: "Personal", value: 1),
                                ],
                                onChanged: (selectedValue) {
                                  print("$selectedValue");
                                  setState(() {});
                                },
                                dropDownItemCount: 2,
                              ),
                            ),
                      widget.isLawyer
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              child: Text(
                                'Lawyer Type',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            )
                          : SizedBox(),
                      widget.isLawyer
                          ? DropdownButtonFormField<String>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              isExpanded: true,
                              menuMaxHeight: 300,
                              value: consultationType,
                              onChanged: (newValue) {
                                setState(() {
                                  consultationType = newValue!;
                                  isConsultationTypeFilled = newValue != null;
                                });
                              },
                              items: categoryNames
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(17, 25, 40, 1)),
                                    borderRadius: BorderRadius.circular(24)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                hintText: "Select Consultation Type",
                                fillColor: Colors.grey[200],
                                filled: true,
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromRGBO(17, 25, 40,
                                          1) // Border color when there's an error
                                      ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(17, 25, 40,
                                        1), // Border color when there's an error and field is focused
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Consultation type is required';
                                }
                                return null;
                              },
                            )
                          : SizedBox(),
                      widget.isLawyer
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Text(
                                    'Lawyer Experience',
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
                                    hinttext: 'Lawyer Experience',
                                    icon: Icons.person_2_outlined),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Text(
                                    'Lawyer Education',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                MyTextField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Company Profession';
                                      }
                                      return null; // Return null if the validation passes
                                    },
                                    isicon2: false,
                                    controller: editProfileController
                                        .companyProfessionController,
                                    hinttext: 'Lawyer Education',
                                    icon: Icons.person_2_outlined),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Text(
                                    'Lawyer About',
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
                                    hinttext: 'Lawyer About',
                                    icon: Icons.person_2_outlined),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Text(
                                    'Lawyer Fee',
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
                                    hinttext: 'Lawyer Fee',
                                    icon: Icons.person_2_outlined),
                              ],
                            )
                          : SizedBox(),
                      //controller.accounttypeController.va
                      editProfileController
                                  .accounttypeController.dropDownValue ==
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
                                            return 'Please Enter Company Profession';
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
                      Obx(() => editProfileController.isloading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColor.teelColor,
                              ),
                            )
                          : RoundedButton(
                              text: 'Save',
                              onPressed: () {
                                print(countrycode.value);
                                if (_formKey.currentState!.validate()) {
                                  editProfileController.isloading.value = true;
                                  editProfileController.updateProfile(
                                    editProfileController.imageFile.value,
                                    countrycode.value,
                                  );
                                }
                                print(countrycode.value);
                              },
                              Color: AppColor.teelColor))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
