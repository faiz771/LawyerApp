import 'package:flutter/material.dart';

class ConsultationForm extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Consultation',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                Text(
                  'Select Consultation Type *',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
                SizedBox(height: 20),
                Text(
                  'Select Country *',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Select Country',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),

                    // errorText:
                    //     !isCountryTypeFilled ? 'Country is required' : null,
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Brief Description of Your Case *',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, perform booking consultation action
                        // Navigate to confirmation page or perform desired action
                        print('Consultation booked successfully');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content: Text('Consultation booked successfully'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Book Consultation',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
