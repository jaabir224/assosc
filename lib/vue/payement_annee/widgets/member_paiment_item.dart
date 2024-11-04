import 'package:assosc/models/cotisation_model.dart';
import 'package:assosc/utils/custom_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MemberPaimentItem extends StatelessWidget {
  CotisationModel cotisation;
  MemberPaimentItem({super.key, required this.cotisation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: MediaQuery.of(context).size.height * 0.11,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CustomStyle.mainColor,
                    width: 2,
                  ),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/medecin_2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              flex: 4,
              child: Text(
                "${cotisation.prenom} ${cotisation.nom} ",
                style: TextStyle(
                  color: CustomStyle.night,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 1,
              child: Icon(
                cotisation.isPaid ? Icons.check_circle_outline : Icons.cancel_rounded,
                size: 30,
                color: cotisation.isPaid  ? CustomStyle.customBlue : CustomStyle.erroColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
