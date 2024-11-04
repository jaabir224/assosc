import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import 'custom_style.dart';

void showRedirectingToLoginDialog(BuildContext context) {
  QuickAlert.show(
      title: null,
      confirmBtnColor: CustomStyle.mainColor,
      confirmBtnTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width / 0.8,
      showCancelBtn: true,
      context: context,
      type: QuickAlertType.info,
      text:
          "Pour poursuivre cette action, veuillez vous connecter à votre compte",
      cancelBtnText: "retour",
      confirmBtnText: "Créer un compte",
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
      onConfirmBtnTap: () {
       // Navigator.pushNamed(context, LoginPage.path);
      });
}

void showAlertToCallAction(BuildContext context, Function() onConfirmBtnTap,
    String title, String message) {
  QuickAlert.show(
    title: title,
    confirmBtnColor: Colors.red.withOpacity(0.8),
    confirmBtnTextStyle: const TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    width: MediaQuery.of(context).size.width / 0.8,
    showCancelBtn: true,
    context: context,
    type: QuickAlertType.error,
    text: message,
    cancelBtnText: "Non",
    confirmBtnText: "Oui",
    onCancelBtnTap: () {
      Navigator.pop(context);
    },
    onConfirmBtnTap: onConfirmBtnTap,
  );
}

void showInfo(BuildContext context, String title, String message) {
  QuickAlert.show(
    title: title,
    confirmBtnColor: Colors.yellow,
    confirmBtnTextStyle: const TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    width: MediaQuery.of(context).size.width / 0.8,
    context: context,
    type: QuickAlertType.info,
    text: message,
    confirmBtnText: "Rétour",
    onConfirmBtnTap: () {
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );
}
