import 'package:custom_alert_snackbar/custom_alert_snackbar.dart';
import 'package:flutter/material.dart';

showScaffoldMessage({
  required BuildContext context,
  required String message,
  required String title,
  required IconData icondata,
  required Color textColor,
  required Color backColor,
}) {
  CustomAlertSnack.init(
    context,
    size: MediaQuery.sizeOf(context),
    title: title,
    text: message,
    backgrounds: backColor,
    color: backColor,
    titleColor: textColor,
    textColor: textColor,
    icons: icondata,
    iconColor: textColor,
    degradeIcon: false,
  );
}
