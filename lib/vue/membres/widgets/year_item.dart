import 'package:flutter/material.dart';

import '../../../utils/custom_style.dart';



// ignore: must_be_immutable
class YearItem extends StatelessWidget {
  final String year;
  bool isPayed = false;
  YearItem({
    super.key,
    required this.year,
    this.isPayed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 35,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
        color: isPayed ? CustomStyle.erroColor : Colors.white,
        boxShadow: [
          BoxShadow(
            color: CustomStyle.night,
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
          child: Text(
        year,
        style: TextStyle(
            color:isPayed? Colors.white: CustomStyle.night,
            fontWeight: FontWeight.w700,
            fontSize: 16),
      )),
    );
  }
}
