import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawyerapp/components/custom_dialog.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/controllers/consultation_controller.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/api_base_url.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:http/http.dart' as http;

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

  List<String> categoryNames = [];
  List<String> countryNames = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final SharedPreferencesService prefsService = SharedPreferencesService();
    final String? token = await prefsService.getToken();
    try {
      final response = await http.get(
        Uri.parse('${Api.ApiBaseUrl}/get-countries'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> countries = jsonData['data'];
        List<String> names = (countries as List<dynamic>)
            .map<String>((countries) => countries['contry_name'] as String)
            .toList();
        setState(() {
          countryNames = names;
        });
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (error) {
      print('Error fetching countries: $error');
    }
  }

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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        isExpanded: true,
                        menuMaxHeight: 300,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        value: country,
                        onChanged: (newValue) {
                          setState(() {
                            country = newValue!;
                            isCountryTypeFilled = newValue != null;
                          });
                        },
                        items: countryNames
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
                          hintText: "Select Country",
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
                      InkWell(
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
                              color: AppColor.teelColor,
                              borderRadius: BorderRadius.circular(
                                  20)), // Change the color as needed
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 16),
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
                              print('Consultation booked successfully');
                              Get.dialog(CustomDialog(
                                  heading: "Consultation Booking",
                                  text:
                                      'Consultation Appointment Booked Successfuly',
                                  buttontext: 'OK'));
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
