import 'package:assosc/models/membre_model.dart';
import 'package:flutter/material.dart';
import '../../../utils/custom_style.dart';

// ignore: must_be_immutable
class MembreItem extends StatelessWidget {
  final MembreModel member;
  Function() onclick;
  MembreItem({
    super.key,
    required this.member,
    required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: onclick,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: MediaQuery.of(context).size.height * 0.18,
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width / 5,
                      width: MediaQuery.of(context).size.width / 5,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/portrait.jpg"),
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: CustomStyle.mainColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        member.matricule,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
