
import 'package:assosc/utils/custom_style.dart';
import 'package:custom_text_form_field_plus/custom_text_form_field_plus.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CustomTextFieldColumn(
    {required String title, required CustomTextFormField customtextfield}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 15,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: TextStyle(
                color: CustomStyle.night, fontWeight: FontWeight.w800),
          ),
        ),
        customtextfield,
        const SizedBox(
          height: 5,
        )
      ],
    ),
  );
}
