import 'package:dropdown_textfield/dropdown_textfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:lawyerapp/components/rounded_button.dart';

class FilterDropDownButton extends StatefulWidget {
  @override
  _FilterDropDownButtonState createState() => _FilterDropDownButtonState();
}

class _FilterDropDownButtonState extends State<FilterDropDownButton> {
  List<String> legalProfessions = [
    'Corporate Lawyer',
    'Family Lawyer',
    'Employment Lawyer',
    'Immigration Lawyer',
    'Personal Injury Lawyer',
    'Intellectual Property Lawyer',
    'Bankruptcy Lawyer',
    'Contract Lawyer',
    'Criminal Lawyer',
    'Estate Planning Lawyer',
    'Tax Lawyer',
    'Civil Litigation Lawyer',
    'Malpractice Lawyers',
    'Real Estate Lawyer',
    'Civil Rights Lawyer',
    'Entertainment Lawyer',
    'Admiralty or Maritime Lawyer',
    'Paralegal',
    'Counsel',
    'Prosecutor',
  ];

  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Show the bottom sheet when the button is pressed
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Select Lawyer Category',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height *
                                  0.6, // Adjust as needed
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: legalProfessions.length,
                              itemBuilder: (context, index) {
                                final profession = legalProfessions[index];
                                return CheckboxListTile(
                                  title: Text(profession),
                                  value:
                                      selectedCategories.contains(profession),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories.add(profession);
                                      } else {
                                        selectedCategories.remove(profession);
                                      }
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        RoundedButton(
                          text: 'Select',
                          onPressed: () {
                            // Process the selected categories, e.g., filter a list
                            print('Selected Categories: $selectedCategories');
                            Navigator.pop(context); // Close the bottom sheet
                          },
                        )
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Process the selected categories, e.g., filter a list
                        //     print('Selected Categories: $selectedCategories');
                        //     Navigator.pop(context); // Close the bottom sheet
                        //   },
                        //   child: Text('Select'),
                        // ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Filter',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 4.w,
            ),
            Icon(Icons.filter_list),
            SizedBox(
              width: 4.w,
            ),
          ],
        ));
  }
}
