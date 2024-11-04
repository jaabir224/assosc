import 'package:flutter/material.dart';

import 'custom_style.dart';

// ignore: non_constant_identifier_names
Widget CustomDropDownField({
  required List<String> items,
  required String title,
  required String hintText,
  required Function(String? newValue) onValueChanged,
  required String? selectedValue,
}) {
  // Options

//"Type de certificat"
//"Sélectionnez le type de certificat"
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: CustomStyle.night,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      DropdownButtonFormField<String>(
        value: selectedValue,
        hint: Text(hintText),
        onChanged: (String? newValue) {
          onValueChanged(newValue);
        },
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: InputDecoration(
          focusColor: CustomStyle.night,
          hoverColor: CustomStyle.night,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: CustomStyle.night),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomStyle.night),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomStyle.night),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomStyle.erroColor),
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}
