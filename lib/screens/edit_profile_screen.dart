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

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      if (widget.isLawyer) {
        editProfileController.lawyerExpController.text =
            widget.user.lawyerExperience!;
        editProfileController.lawyerEduController.text =
            widget.user.lawyerEducation!;
        editProfileController.lawyerAboutController.text =
            widget.user.lawyerAbout!;
        editProfileController.lawyerFeeController.text =
            widget.user.lawyerFees.toString();
        categoryID = widget.user.lawyerType!;
      }
      email = widget.user.email;

      countrycode.value = widget.user.countryCode!;
    });
  }

  List<Map<String, dynamic>> categoryData = [];
  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('${Api.ApiBaseUrl}/lawyer/categories'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> categories = jsonData['data'];

        // Modify to store category objects with name and ID
        categoryData = categories
            .map((category) => {
                  'category_name': category['category_name'] as String,
                  'id': category['id'] as int,
                })
            .toList();
        print(categoryData);

        setState(() {
          // Update with categoryData (containing both name and ID)
          categoryData = categoryData; // Assuming you have a variable for it
        });
      }
      // if (response.statusCode == 200) {
      //   final jsonData = json.decode(response.body);
      //   final List<dynamic> categories = jsonData['data'];
      //   List<String> names = (categories as List<dynamic>)
      //       .map<String>((category) => category['category_name'] as String)
      //       .toList();
      //   setState(() {
      //     categoryNames = names;
      //   });
      // }
      else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  int categoryID = 0;
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
            AppLocalizations.of(context)!.editProfile,
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
                                        text: AppLocalizations.of(context)!
                                            .pick_from_gallery,
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
                                        text: AppLocalizations.of(context)!
                                            .take_a_photo,
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
                          AppLocalizations.of(context)!.full_name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      MyTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.enter_name;
                          }
                          return null; // Return null if the validation passes
                        },
                        hinttext: AppLocalizations.of(context)!.full_name,
                        isicon2: false,
                        icon: Icons.person,
                        controller: editProfileController.nameController,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Text(
                          AppLocalizations.of(context)!.phone,
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
                            return AppLocalizations.of(context)!.phone_empty;
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
                          hintText: AppLocalizations.of(context)!.phone,
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
                          AppLocalizations.of(context)!.email,
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
                                AppLocalizations.of(context)!.account_type,
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
                                    return AppLocalizations.of(context)!
                                        .select_account_type;
                                  }
                                  return null;
                                } // Return null if the validation passes
                                ,
                                controller:
                                    editProfileController.accounttypeController,
                                textFieldDecoration: InputDecoration(
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  hintText: AppLocalizations.of(context)!
                                      .account_type,
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
                                dropDownList: [
                                  DropDownValueModel(
                                    name: AppLocalizations.of(context)!.company,
                                    value: 0,
                                  ),
                                  DropDownValueModel(
                                      name: AppLocalizations.of(context)!
                                          .personal,
                                      value: 1),
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
                                AppLocalizations.of(context)!
                                    .select_lawyer_type,
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
                              value: widget.user.lawyer_category,
                              onChanged: (newValue) {
                                setState(() {
                                  consultationType = newValue!;
                                  isConsultationTypeFilled = newValue != null;
                                  final int selectedCategoryId =
                                      categoryData.firstWhere(
                                          (category) =>
                                              category['category_name'] ==
                                              newValue,
                                          orElse: () => <String, Object>{
                                                'id': -1,
                                                'category_name': 'NotFound'
                                              })['id'];
                                  print(
                                      "Selected Category ID: $selectedCategoryId");
                                  setState(() {
                                    categoryID = selectedCategoryId;
                                    print(
                                        'Category ID After Change $categoryID');
                                  });
                                });
                              },
                              items: categoryData.map<DropdownMenuItem<String>>(
                                (category) {
                                  final String categoryName =
                                      category['category_name'];
                                  print(
                                      "Creating DropdownMenuItem for: $categoryName");
                                  return DropdownMenuItem<String>(
                                    value: categoryName,
                                    child: Text(categoryName),
                                  );
                                },
                              ).toList(),
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
                                hintText: AppLocalizations.of(context)!
                                    .select_lawyer_type,
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
                                  return AppLocalizations.of(context)!
                                      .lawyer_type_required;
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
                                    AppLocalizations.of(context)!
                                        .lawyer_experience,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                MyTextField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .lawyer_experience_required;
                                      }
                                      return null; // Return null if the validation passes
                                    },
                                    isicon2: false,
                                    controller: editProfileController
                                        .lawyerExpController,
                                    hinttext: AppLocalizations.of(context)!
                                        .lawyer_experience,
                                    icon: Icons.person_2_outlined),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .lawyer_education,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                MyTextField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .lawyer_education_required;
                                      }
                                      return null; // Return null if the validation passes
                                    },
                                    isicon2: false,
                                    controller: editProfileController
                                        .lawyerEduController,
                                    hinttext: AppLocalizations.of(context)!
                                        .lawyer_education,
                                    icon: Icons.person_2_outlined),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Text(
                                    AppLocalizations.of(context)!.lawyer_about,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                MyTextField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .lawyer_about_required;
                                      }
                                      return null; // Return null if the validation passes
                                    },
                                    isicon2: false,
                                    controller: editProfileController
                                        .lawyerAboutController,
                                    hinttext: AppLocalizations.of(context)!
                                        .lawyer_about,
                                    icon: Icons.person_2_outlined),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Text(
                                    AppLocalizations.of(context)!.lawyer_fee,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                MyTextField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .lawyer_fee_required;
                                      }
                                      return null; // Return null if the validation passes
                                    },
                                    isicon2: false,
                                    controller: editProfileController
                                        .lawyerFeeController,
                                    hinttext: AppLocalizations.of(context)!
                                        .lawyer_fee,
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
                                  AppLocalizations.of(context)!.company
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 5),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .company_name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    MyTextField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .enter_company_name;
                                          }
                                          return null; // Return null if the validation passes
                                        },
                                        isicon2: false,
                                        controller: editProfileController
                                            .companyNameController,
                                        hinttext: AppLocalizations.of(context)!
                                            .company_name,
                                        icon: Icons.person_2_outlined),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 5),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .company_profession,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    MyTextField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .enter_company_profession;
                                          }
                                          return null; // Return null if the validation passes
                                        },
                                        isicon2: false,
                                        controller: editProfileController
                                            .companyProfessionController,
                                        hinttext: AppLocalizations.of(context)!
                                            .company_profession,
                                        icon: Icons.person_2_outlined),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 5),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .company_location,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    MyTextField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .enter_company_location;
                                          }
                                          return null; // Return null if the validation passes
                                        },
                                        isicon2: false,
                                        controller: editProfileController
                                            .companyLocationController,
                                        hinttext: AppLocalizations.of(context)!
                                            .company_location,
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
                              text: AppLocalizations.of(context)!.save_changes,
                              onPressed: widget.isLawyer
                                  ? () {
                                      if (_formKey.currentState!.validate()) {
                                        print('Category ID On Tap $categoryID');
                                        editProfileController.isloading.value =
                                            true;
                                        editProfileController
                                            .updateLawyerProfile(
                                                editProfileController
                                                    .imageFile.value,
                                                countrycode.value,
                                                categoryID);
                                      }
                                    }
                                  : () {
                                      print(countrycode.value);
                                      if (_formKey.currentState!.validate()) {
                                        editProfileController.isloading.value =
                                            true;
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
