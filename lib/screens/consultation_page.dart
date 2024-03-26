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

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  void initState() {
    super.initState();
    fetchCategories();
    fetchCountries();
  }

  int countryID = 0;
  List<Map<String, dynamic>> countryData = [];
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
        countryData = countries
            .map((category) => {
                  'contry_name': category['contry_name'] as String,
                  'id': category['id'] as int,
                })
            .toList();
        print(countryData);

        setState(() {
          // Update with categoryData (containing both name and ID)
          countryData = countryData; // Assuming you have a variable for it
        });
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (error) {
      print('Error fetching countries: $error');
    }
  }

  int categoryID = 0;
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
              title: Text(
                AppLocalizations.of(context)!.book_consultation,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
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
                      Text(
                        AppLocalizations.of(context)!.select_consultation_type,
                        style: const TextStyle(
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
                            final int selectedCategoryId =
                                categoryData.firstWhere(
                                    (category) =>
                                        category['category_name'] == newValue,
                                    orElse: () => <String, Object>{
                                          'id': -1,
                                          'category_name': 'NotFound'
                                        })['id'];
                            print("Selected Category ID: $selectedCategoryId");
                            setState(() {
                              categoryID = selectedCategoryId;
                              print('Category ID After Change $categoryID');
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
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(17, 25, 40, 1)),
                              borderRadius: BorderRadius.circular(24)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          hintText: AppLocalizations.of(context)!
                              .select_consultation_type,
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
                                .consultation_type_required;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.select_country,
                        style: const TextStyle(
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
                            final int selectedCountryId =
                                countryData.firstWhere(
                                    (category) =>
                                        category['contry_name'] == newValue,
                                    orElse: () => <String, Object>{
                                          'id': -1,
                                          'contry_name': 'NotFound'
                                        })['id'];
                            print("Selected Category ID: $selectedCountryId");
                            setState(() {
                              countryID = selectedCountryId;
                              print('Country ID After Change $countryID');
                            });
                          });
                        },
                        items: countryData.map<DropdownMenuItem<String>>(
                          (category) {
                            final String countryName = category['contry_name'];
                            // print(
                            //     "Creating DropdownMenuItem for: $countryName");
                            return DropdownMenuItem<String>(
                              value: countryName,
                              child: Text(countryName),
                            );
                          },
                        ).toList(),
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
                          hintText:
                              AppLocalizations.of(context)!.select_country,
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
                                .country_required;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.brief_description,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.descriptionController,
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
                            return AppLocalizations.of(context)!
                                .case_description_required;
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
                          hintText: AppLocalizations.of(context)!
                              .provide_brief_description,
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
                                        controller.pickImage(ImageSource
                                            .gallery); // Pick image from gallery
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
                                        controller.pickImage(ImageSource
                                            .camera); // Pick image from camera
                                      },
                                      text: AppLocalizations.of(context)!
                                          .take_a_photo,
                                      Color: AppColor.teelColor,
                                    ),
                                    const SizedBox(height: 16),
                                    RoundedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                        // controller.pickImage(ImageSource
                                        //     .camera); // Pick image from camera
                                        controller.pickPDF();
                                      },
                                      text: AppLocalizations.of(context)!.pdf,
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
                          child: Row(
                            children: [
                              const Icon(
                                Icons.file_upload,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.upload_document,
                                style: const TextStyle(
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
                          Text(
                            AppLocalizations.of(context)!.accept_privacy_policy,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
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
                  child: controller.isloading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColor.teelColor,
                          ),
                        )
                      : RoundedButton(
                          text: AppLocalizations.of(context)!.book_consultation,
                          onPressed: controller.agreed.value
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.isloading.value = true;
                                    controller.bookConsultation(
                                        consultationType: categoryID,
                                        countryId: countryID,
                                        filePath:
                                            controller.imageFile.value?.path ??
                                                controller.selectedPDF);
                                    // print('Consultation booked successfully');
                                    // Get.dialog(CustomDialog(
                                    //   heading: AppLocalizations.of(context)!
                                    //       .provide_brief_description,
                                    //   text: AppLocalizations.of(context)!
                                    //       .consultation_booked_successfully,
                                    //   buttontext: AppLocalizations.of(context)!.ok,
                                    // ));
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
