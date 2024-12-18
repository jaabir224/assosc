import 'package:assosc/models/membre_model.dart';
import 'package:assosc/providers/member_provider.dart';
import 'package:assosc/utils/custom_style.dart';
import 'package:assosc/vue/detail_membre/detail_membre.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/membre_item.dart';

class Membres extends StatelessWidget {
  const Membres({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Consumer<MemberProvider>(
        builder: (context, memberProvider, child) {
          if (memberProvider.members.isEmpty) {
            return Center(
              child: Text(
                "Aucun Membre pour l'instant ,",
                style: TextStyle(
                  color: CustomStyle.night,
                  fontWeight: FontWeight.w800,
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: memberProvider.members.length,
                  itemBuilder: (context, index) {
                    MembreModel member = memberProvider.members[index];
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: MembreItem(
                          member: member,
                          onclick: () {
                            Navigator.pushNamed(
                              context,
                              DetailMembre.path,
                              arguments: {
                                "member": member,
                              },
                            );
                          }),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
