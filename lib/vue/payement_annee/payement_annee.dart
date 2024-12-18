import 'package:assosc/services/database.dart';
import 'package:assosc/utils/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cotisation_model.dart';
import '../../providers/member_provider.dart';
import 'widgets/member_paiment_item.dart';
import 'widgets/year_item_paiment.dart';

class PayementAnnee extends StatefulWidget {
  const PayementAnnee({super.key});

  @override
  State<PayementAnnee> createState() => _PayementAnneeState();
}

class _PayementAnneeState extends State<PayementAnnee> {
  int selectedIndex = 0;
  late MemberProvider memberProvider;

  @override
  void initState() {
    super.initState();
    memberProvider = Provider.of<MemberProvider>(context, listen: false);

    setState(() {
      memberProvider.getCotisationsWithMembers();

      if (memberProvider.years.isNotEmpty) {
        memberProvider
            .filterCotisationsByYear(memberProvider.years[selectedIndex]);
      }
    });
  }

  void _updateOneCotisations(CotisationModel cotisation) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmer paiement"),
          content: Text(
            "Êtes-vous sûr de vouloir confirmer que le  membre ${cotisation.prenom} ${cotisation.nom}"
            "a réglé sa cotisation pour l'année ${cotisation.annee} ?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Annuler",
                style: TextStyle(
                  color: CustomStyle.erroColor,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomStyle.antiflashWhite,
              ),
              onPressed: () async {
                await DatabaseMethods().updateCotisationToPaid(
                  cotisationId: cotisation.id.toString(),
                );

                setState(() {
                  memberProvider.cotisations
                      .firstWhere(
                        (cot) =>
                            cot.membreId == cotisation.membreId &&
                            cot.annee == cotisation.annee,
                      )
                      .isPaid = true;
                });

                Navigator.of(context).pop();
              },
              child: Text(
                "Confirmer",
                style: TextStyle(
                  color: CustomStyle.mainColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 22,
            child: Consumer<MemberProvider>(
              builder: (context, memberProvider, child) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: memberProvider.years.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: YearItemPaiment(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            memberProvider.filterCotisationsByYear(
                                memberProvider.years[index]);
                          });
                        },
                        Year: memberProvider.years[index].toString(),
                        isActive: selectedIndex == index,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Consumer<MemberProvider>(
              builder: (context, memberProvider, child) {
                List<CotisationModel> cotisations =
                    memberProvider.filteredCotisations;

                return ListView.builder(
                  itemCount: cotisations.length,
                  itemBuilder: (context, index) {
                    CotisationModel cotisation = cotisations[index];
                    return MemberPaimentItem(
                      cotisation: cotisation,
                      onChange: () {
                        _updateOneCotisations(cotisation);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
