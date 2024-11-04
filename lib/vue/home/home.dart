

import 'package:flutter/material.dart';

import '../../utils/custom_style.dart';
import '../choice_add/choice_add.dart';
import '../membres/membres.dart';
import '../payement_annee/payement_annee.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static String path = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = 0;
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
          leading: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              height: MediaQuery.of(context).size.width / 4.5,
              width: MediaQuery.of(context).size.width / 4.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: CustomStyle.mainColor,
                  width: 2,
                ),
                image: const DecorationImage(
                    image: AssetImage("assets/images/medecin_2.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
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
