import 'package:assosc/models/membre_model.dart';
import 'package:assosc/providers/member_provider.dart';
import 'package:assosc/utils/custom_style.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/membre_item.dart';

class Membres extends StatefulWidget {
  const Membres({super.key});

  @override
  State<Membres> createState() => _MembresState();
}

class _MembresState extends State<Membres> {
  late MemberProvider _memberProvider;
  bool isCharging = true;

  @override
  void initState() {
    _afterInit();
    super.initState();
  }

  _afterInit() async {
    _memberProvider = Provider.of<MemberProvider>(context, listen: false);
    await _memberProvider.getMembers();
    setState(() {
      isCharging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: isCharging
          ? Center(
              child: CircularProgressIndicator(
                color: CustomStyle.secondColor,
              ),
            )
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: _memberProvider.members.length,
                  itemBuilder: (context, index) {
                    MembreModel member = _memberProvider.members[index];
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: MembreItem(
                        member: member,
                      ),
                    );
                  },
                ))
              ],
            ),
    );
  }
}
