import 'package:flutter/material.dart';

import '../../../utils/custom_style.dart';

// ignore: must_be_immutable
class YearItemPaiment extends StatelessWidget {
  final String Year;
  bool isActive = false;
  Function() onTap;
  YearItemPaiment({
    super.key,
    required this.Year,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        height: MediaQuery.of(context).size.height / 24,
        width: MediaQuery.of(context).size.width * 0.22,
        decoration: BoxDecoration(
          color: isActive ? CustomStyle.night : Colors.white,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: CustomStyle.night,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: CustomStyle.mainColor,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]
              : [
                  BoxShadow(
                    color: CustomStyle.night,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            Year,
            style: TextStyle(
              color: isActive ? Colors.white : CustomStyle.night,
              fontWeight: FontWeight.bold,
              fontSize: isActive ? 18 : 16,
            ),
          ),
        ),
      ),
    );
  }
}
