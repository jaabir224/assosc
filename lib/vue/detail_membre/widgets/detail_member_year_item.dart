import 'package:flutter/material.dart';

import '../../../models/simple_cotisation_model.dart';
import '../../../utils/custom_style.dart';

class DetailMemberYearItem extends StatelessWidget {
  final SimpleCotisationModel cotisation;
  const DetailMemberYearItem({super.key, required this.cotisation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cotisation.isPaid ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        border: !cotisation.isPaid
            ? Border.all(
                color: CustomStyle.erroColor,
              )
            : null,
        boxShadow: cotisation.isPaid
            ? [
                BoxShadow(
                  color: CustomStyle.secondColor,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
         cotisation.annee.toString(),
          style: TextStyle(
            color: CustomStyle.mainColor,
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width * 0.035,
          ),
        ),
      ),
    );
  }
}
