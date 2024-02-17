import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/consultation_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class ConsultationForm extends StatefulWidget {
  const ConsultationForm({super.key});

  @override
  _ConsultationFormState createState() => _ConsultationFormState();
}

class _ConsultationFormState extends State<ConsultationForm> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form

  var consultationType;
  var caseDescription;
  var country;
  bool isConsultationTypeFilled = false;
  bool isCountryTypeFilled = false;
  bool isCaseDescriptionFilled = false;
  final ConsultationController controller = Get.put(ConsultationController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: AppColor.teelColor,
              title: const Text(
                'Book Consultation',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey, // Assign the GlobalKey to the Form
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Select Consultation Type',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: consultationType,
                        onChanged: (newValue) {
                          setState(() {
                            consultationType = newValue!;
                            isConsultationTypeFilled = newValue != null;
                          });
                        },
                        items: [' Type 1', ' Type 2', ' Type 3']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
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
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Select Country',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: country,
                        onChanged: (newValue) {
                          setState(() {
                            country = newValue!;
                            isCountryTypeFilled = newValue != null;
                          });
                        },
                        items: ['Pakistan', 'Afghanistan', 'India']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
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
                            return 'Country is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Brief Description of Your Case',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        onChanged: (value) {
                          setState(() {
                            caseDescription = value;
                            isCaseDescriptionFilled = value.isNotEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Case description is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(17, 25, 40, 1)),
                              borderRadius: BorderRadius.circular(24)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          hintText: "Provide a breif description of your case",
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColor.teelColor,
                            borderRadius: BorderRadius.circular(
                                20)), // Change the color as needed
                        padding:
                            const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.file_upload,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Upload Document(Optional)',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                controller.agreed.value =
                                    !controller.agreed.value;
                              },
                              child: Obx(
                                () => Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.agreed.value
                                        ? AppColor.teelColor
                                        : Colors.white,
                                    border: Border.all(
                                      color: AppColor.teelColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: controller.agreed.value
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 12,
                                          )
                                        : null,
                                  ),
                                ),
                              )),
                          const SizedBox(width: 10),
                          const Text(
                            'Accept Privacy Policy',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Obx(
                () => SizedBox(
                  height: 55,
                  child: RoundedButton(
                    text: "Book Consultation",
                    onPressed: controller.agreed.value
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              // Form is valid, perform booking consultation action
                              // Navigate to confirmation page or perform desired action
                              // print('Consultation booked successfully');
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return AlertDialog(
                              //       title: Text('Success'),
                              //       content: Text('Consultation booked successfully'),
                              //       actions: <Widget>[
                              //         TextButton(
                              //           onPressed: () {
                              //             Navigator.of(context).pop();
                              //           },
                              //           child: Text('OK'),
                              //         ),
                              //       ],
                              //     );
                              //   },
                              // );
                            }
                          }
                        : () {},
                    Color: controller.agreed.value
                        ? AppColor.teelColor
                        : AppColor.greyColor,
                  ),
                ),
              ),
            )));
  }
}
