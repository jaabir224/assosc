
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/custom_style.dart';
import '../vue/add_user/add_user.dart';
import '../vue/choice_add/widgets/choice_add_item.dart';


class ChoiceAdd extends StatelessWidget {
  const ChoiceAdd({super.key});
  static String path = "/choice_add";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: CustomStyle.night,
            size: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.center,
              child: ChoiceAddItem(
                title: "Ajouter une année",
                backColor: CustomStyle.mainColor,
                onClicked: () {},
                iconData: FontAwesomeIcons.calendarCheck,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ChoiceAddItem(
                title: "Ajouter un membre",
                backColor: CustomStyle.secondColor,
                onClicked: () {
                  Navigator.pushNamed(context, AddUser.path);
                },
                iconData: FontAwesomeIcons.users,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
