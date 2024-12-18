import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'custom_style.dart';

// ignore: non_constant_identifier_names
Widget CustomPhoneField(
    {required String title,
    required Function(PhoneNumber) onPhoneNumberChanged}) {
  FocusNode focusNode = FocusNode();

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 22,
      vertical: 5,
    ),
    child: Column(
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
        IntlPhoneField(
          focusNode: focusNode,
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
          languageCode: "fr",
          initialCountryCode: "GN",
          invalidNumberMessage: "Numéro de téléphone invalide",
          onChanged: (phone) {
            onPhoneNumberChanged(phone);
          },
          onCountryChanged: (country) {
        
          },
        ),
      ],
    ),
  );
}
