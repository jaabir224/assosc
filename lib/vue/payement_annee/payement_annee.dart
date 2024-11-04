import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 22,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: YearItemPaiment(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    Year: "2023",
                    isActive: selectedIndex == index,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return MemberPaimentItem(
                  isPaid: index == 2,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
