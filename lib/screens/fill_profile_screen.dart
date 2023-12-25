import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/screens/client_homepage_screen.dart';
import 'package:lawyerapp/screens/lawyer_homepage_screen.dart';
import 'package:lawyerapp/screens/select_user_type.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Fill Your Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        'assets/images/person.png',
                      ),
                    ),
                    Positioned(
                      bottom: 18.h,
                      // left: MediaQuery.of(context).size.height * 0.15,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                    child: DropDownTextField(
                      textFieldDecoration: InputDecoration(
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
                      dropDownList: [
                        DropDownValueModel(
                            name: 'Corporate Lawyer', value: "value1"),
                        DropDownValueModel(
                            name: 'Family Lawyer', value: "value2"),
                        DropDownValueModel(
                            name: 'Employment Lawyer', value: "value3"),
                        DropDownValueModel(
                            name: 'Immigration Lawyer', value: "value4"),
                        DropDownValueModel(
                            name: 'Personal Injury Lawyer', value: "value5"),
                        DropDownValueModel(
                            name: 'Intellectual Property Lawyer',
                            value: "value6"),
                        DropDownValueModel(
                            name: 'Bankruptcy Lawyer', value: "value7"),
                        DropDownValueModel(
                            name: 'Contract Lawyer', value: "value8"),
                        DropDownValueModel(
                            name: 'Criminal Lawyer', value: "value9"),
                        DropDownValueModel(
                            name: 'Estate Planning Lawyer', value: "value10"),
                        DropDownValueModel(
                            name: 'Tax Lawyer', value: "value11"),
                        DropDownValueModel(
                            name: 'Civil Litigation Lawyer', value: "value12"),
                        DropDownValueModel(
                            name: 'Malpractice Lawyer', value: "value13"),
                        DropDownValueModel(
                            name: 'Real Estate Lawyer', value: "value14"),
                        DropDownValueModel(
                            name: 'Civil Rights Lawyer', value: "value15"),
                        DropDownValueModel(
                            name: 'Entertainment Lawyer', value: "value16"),
                        DropDownValueModel(
                            name: 'Admiralty or Maritime Lawyer',
                            value: "value17"),
                        DropDownValueModel(name: 'Paralegal', value: "value18"),
                        DropDownValueModel(name: 'Counsel', value: "value19"),
                        DropDownValueModel(
                            name: 'Prosecutor', value: "value20"),
                      ],
                      onChanged: (val) {},
                    )),
                MyTextField(hinttext: 'phone', icon: Icons.phone_outlined),
                MyTextField(hinttext: 'Education', icon: Icons.school_outlined),
                MyTextField(
                    hinttext: 'Experience', icon: Icons.description_outlined),
                MyTextField(hinttext: 'About', icon: Icons.info_outline),
                MyTextField(hinttext: 'Fee', icon: Icons.attach_money),
                MyTextField(hinttext: 'Address', icon: Icons.place_outlined),
                SizedBox(
                  height: 15.h,
                ),
                RoundedButton(
                    text: 'Save',
                    onPressed: () {
                      Get.to(LawyerHomepage());
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
