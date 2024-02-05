import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/lawyer_categories_controller.dart';
import 'package:lawyerapp/controllers/lawyer_profile_controller.dart';
import 'package:lawyerapp/screens/lawyer_homepage_screen.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class FillProfileScreen extends StatelessWidget {
  String email = '';
  FillProfileScreen({super.key, required this.email});

  LawyerProfileController controller = Get.put(LawyerProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),

                // Stack(
                //   alignment: Alignment.bottomRight,
                //   children: [
                //     const CircleAvatar(
                //       radius: 75,
                //       backgroundColor: Colors.white,
                //       backgroundImage: AssetImage(
                //         'assets/images/person.png',
                //       ),
                //     ),
                //     Positioned(
                //       bottom: 18.h,
                //       // left: MediaQuery.of(context).size.height * 0.15,
                //       child: Container(
                //           decoration: BoxDecoration(
                //               color: Colors.black,
                //               borderRadius: BorderRadius.circular(6)),
                //           child: const Padding(
                //             padding: EdgeInsets.all(4.0),
                //             child: Icon(
                //               Icons.edit,
                //               color: Colors.white,
                //             ),
                //           )),
                //     )
                //   ],
                // ),
                CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('assets/images/lawyerlogo.jpg'),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Fill Your Profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20.h,
                ),

                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                    child: DropDownTextField(
                      controller: controller.lawyerTypeController,
                      textFieldDecoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 15.w),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(17, 25, 40, 1)),
                              borderRadius: BorderRadius.circular(24)),
                          hintText: 'Lawyer Category',
                          fillColor: Colors.grey[200],
                          filled: true),
                      clearOption: true,
                      enableSearch: true,
                      // controller: _rolecontroller,
                      validator: (value) {
                        if (value == null) {
                          return "Required field";
                        } else {
                          return null;
                        }
                      },
                      dropDownItemCount: 4,
                      dropDownList: const [
                        DropDownValueModel(
                            name: 'Civil Litigation', value: "1"),
                        DropDownValueModel(
                            name: 'Criminal Defense', value: "2"),
                        DropDownValueModel(name: 'Family Law', value: "3"),
                        DropDownValueModel(name: 'Personal Injury', value: "4"),
                        DropDownValueModel(name: 'Real Estate', value: "5"),
                        // DropDownValueModel(
                        //     name: 'Intellectual Property Lawyer',
                        //     value: "value6"),
                        // DropDownValueModel(
                        //     name: 'Bankruptcy Lawyer', value: "value7"),
                        // DropDownValueModel(
                        //     name: 'Contract Lawyer', value: "value8"),
                        // DropDownValueModel(
                        //     name: 'Criminal Lawyer', value: "value9"),
                        // DropDownValueModel(
                        //     name: 'Estate Planning Lawyer', value: "value10"),
                        // DropDownValueModel(
                        //     name: 'Tax Lawyer', value: "value11"),
                        // DropDownValueModel(
                        //     name: 'Civil Litigation Lawyer', value: "value12"),
                        // DropDownValueModel(
                        //     name: 'Malpractice Lawyer', value: "value13"),
                        // DropDownValueModel(
                        //     name: 'Real Estate Lawyer', value: "value14"),
                        // DropDownValueModel(
                        //     name: 'Civil Rights Lawyer', value: "value15"),
                        // DropDownValueModel(
                        //     name: 'Entertainment Lawyer', value: "value16"),
                        // DropDownValueModel(
                        //     name: 'Admiralty or Maritime Lawyer',
                        //     value: "value17"),
                        // DropDownValueModel(name: 'Paralegal', value: "value18"),
                        // DropDownValueModel(name: 'Counsel', value: "value19"),
                        // DropDownValueModel(
                        //     name: 'Prosecutor', value: "value20"),
                      ],
                      onChanged: (val) {},
                    )),
                // MyTextField(hinttext: 'phone', icon: Icons.phone_outlined),
                MyTextField(
                    controller: controller.lawyerEducationController,
                    hinttext: 'Education',
                    icon: Icons.school_outlined),
                MyTextField(
                    controller: controller.lawyerExperienceController,
                    hinttext: 'Experience',
                    icon: Icons.description_outlined),
                MyTextField(
                    controller: controller.lawyerAboutController,
                    hinttext: 'About',
                    icon: Icons.info_outline),
                // MyTextField(hinttext: 'Fee', icon: Icons.attach_money),
                // MyTextField(hinttext: 'Address', icon: Icons.place_outlined),
                SizedBox(
                  height: 15.h,
                ),
                RoundedButton(
                    Color: AppColor.teelColor,
                    text: 'Save',
                    onPressed: () {
                      controller.createLawyerProfile(email: email);
                    }),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
