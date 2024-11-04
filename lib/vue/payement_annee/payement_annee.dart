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

@override
  void initState() {
    super.initState();
    // Appel à la fonction de filtrage pour initialiser avec la première année
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final memberProvider = Provider.of<MemberProvider>(context, listen: false);
      if (memberProvider.years.isNotEmpty) {
        memberProvider.filterCotisationsByYear(memberProvider.years[selectedIndex]);
      }
    });
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
                            // Appel à la méthode de filtrage
                            memberProvider.filterCotisationsByYear(memberProvider.years[index]);
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
                // Utilisez la liste des cotisations filtrées
                List<CotisationModel> cotisations = memberProvider.filteredCotisations;

                return ListView.builder(
                  itemCount: cotisations.length,
                  itemBuilder: (context, index) {
                    CotisationModel cotisation = cotisations[index];
                    return MemberPaimentItem(
                      cotisation: cotisation,
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
