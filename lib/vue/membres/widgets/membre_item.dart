import 'package:assosc/models/membre_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/custom_style.dart';
import 'year_item.dart';

class MembreItem extends StatelessWidget {
  final MembreModel member;
  const MembreItem({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: CustomStyle.night,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 5,
                    width: MediaQuery.of(context).size.width / 5,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/medecin_2.jpg"),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${member.prenom} ${member.nom}",
                    style: TextStyle(
                        color: CustomStyle.night,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  )
                ],
              ),
              Divider(
                color: CustomStyle.night,
              ),
              const Spacer(),
              Row(
                children: [
                  YearItem(year: "2022"),
                  YearItem(
                    year: "2023",
                    isPayed: true,
                  ),
                  const Spacer(),
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: CustomStyle.mainColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "01",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
