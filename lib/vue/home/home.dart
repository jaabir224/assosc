// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_style.dart';
import '../choice_add/choice_add.dart';
import '../login/login.dart';
import '../membres/membres.dart';
import '../payement_annee/payement_annee.dart';

class Home extends StatefulWidget {
  int initialIndex = 0;
  Home({super.key, this.initialIndex = 0});

  static String path = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  void switchIndex(i) {
    setState(() {
      index = i;
    });
  }

  Color switchedColor(int myIndex) {
    return myIndex == index ? Colors.white : CustomStyle.night;
  }

  Widget toggleView() {
    switch (index) {
      case 0:
        return const Membres();
      case 1:
        return const PayementAnnee();

      default:
        return const Membres();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomStyle.mainColor,
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Login.path,
                    (route) => false,
                  );
                },
                child: Text(
                  "Se déconnecter",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        body: toggleView(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, ChoiceAdd.path);
          },
          backgroundColor: CustomStyle.mainColor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: CustomStyle.antiflashWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: index == 0
                      ? [
                          BoxShadow(
                            color: CustomStyle.night,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                          BoxShadow(
                            color: CustomStyle.mainColor,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                  color: index == 0 ? CustomStyle.night : null,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  icon: Icon(
                    Icons.person,
                    color: switchedColor(0),
                    size: 40,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: index == 1
                      ? [
                          BoxShadow(
                            color: CustomStyle.night,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                          BoxShadow(
                            color: CustomStyle.mainColor,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                  color: index == 1 ? CustomStyle.night : null,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: switchedColor(1),
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
