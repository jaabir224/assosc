import 'package:assosc/models/cotisation_model.dart';
import 'package:assosc/utils/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class MemberPaimentItem extends StatelessWidget {
  CotisationModel cotisation;
  Function()? onChange;
  MemberPaimentItem({
    super.key,
    required this.cotisation,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: MediaQuery.of(context).size.height * 0.11,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color:
              cotisation.isPaid ? CustomStyle.mainColor : CustomStyle.erroColor,
        ),
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
                    color: cotisation.isPaid
                        ? CustomStyle.mainColor
                        : CustomStyle.erroColor,
                  ),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/portrait.jpg"),
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
            !cotisation.isPaid
                ? Icon(
                    FontAwesomeIcons.xmark,
                    color: CustomStyle.erroColor,
                    size: 16,
                  )
                : const SizedBox.shrink(),
            Flexible(
              flex: cotisation.isPaid ? 1 : 3,
              child: cotisation.isPaid
                  ? Icon(
                      FontAwesomeIcons.check,
                      color: CustomStyle.mainColor,
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomStyle.antiflashWhite,
                        ),
                        onPressed: onChange,
                        child: Text(
                          "Payer",
                          style: TextStyle(
                            color: CustomStyle.mainColor,
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
