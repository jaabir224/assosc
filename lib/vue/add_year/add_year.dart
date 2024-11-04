import 'package:assosc/utils/CustomTextFieldColumn.dart';
import 'package:custom_text_form_field_plus/custom_text_form_field_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/database.dart';
import '../../utils/app_message.dart';
import '../../utils/custom_style.dart';
import '../home/home.dart';

class AddYear extends StatefulWidget {
  const AddYear({super.key});
  static String path = "add_year";

  @override
  State<AddYear> createState() => _AddYearState();
}

class _AddYearState extends State<AddYear> {
  TextEditingController yearController = TextEditingController();
  bool isLoading = false; // Variable d'état pour gérer le chargement

  @override
  void initState() {
    super.initState();
  }

  addingYear() async {
    if (yearController.text.isNotEmpty) {
      setState(() {
        isLoading = true; // Indique que le chargement commence
      });

      Map<String, dynamic> yearInfo = {
        "annee": int.parse(yearController.text),
        "dateCreation": DateTime.now(),
        "isActive": true,
      };

      await DatabaseMethods().addYear(yearInfo).then((onValue) {
        showScaffoldMessage(
          context: context,
          message: "L'année a été ajoutée avec succès.",
          title: "Ajout Réussie",
          icondata: Icons.check,
          textColor: Colors.white,
          backColor: CustomStyle.secondColor,
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
          (Route<dynamic> route) => false,
        );
      }).catchError((error) {
        // Gérer les erreurs ici si nécessaire
      }).whenComplete(() {
        setState(() {
          isLoading = false; // Indique que le chargement est terminé
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                color: CustomStyle.night,
                border: const Border(
                  right: BorderSide(color: Colors.grey, width: 10),
                  bottom: BorderSide(color: Colors.grey, width: 10),
                  left: BorderSide(color: Colors.grey, width: 10),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(120),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Spacer(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FontAwesomeIcons.calendarDay,
                      color: CustomStyle.night,
                      size: 38,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFieldColumn(
            title: "Année",
            customtextfield: CustomTextFormField(
              keyboardType: TextInputType.number,
              controller: yearController,
              hintText: "Entrer l'année ",
              validator: (String? value) =>
                  Validations.contactNumberValidation(value),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              addingYear();
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: CustomStyle.night,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: isLoading // Vérifiez si le chargement est en cours
                    ? const CircularProgressIndicator(
                        color: Colors.white, // Couleur du chargeur
                      )
                    : const Text(
                        "Ajouter ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
