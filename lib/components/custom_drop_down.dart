import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String hintText;
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final Function(String?) onChanged;

  const CustomDropdownField({
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(24),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration.collapsed(
          hintText: hintText,
        ),
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
