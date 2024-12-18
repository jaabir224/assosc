import 'dart:io';
import 'package:custom_text_form_field_plus/custom_text_form_field_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../../services/database.dart';
import '../../utils/CustomTextFieldColumn.dart';
import '../../utils/app_message.dart';
import '../../utils/custom_style.dart';
import '../home/home.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  static String path = "/add_user";

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  File? selectImage;
  TextEditingController prenomController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController posteController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false; // Add loading state

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;

    final imagePath = returnedImage.path;
    final imageFile = File(imagePath);

    setState(() {
      selectImage = imageFile;
    });
  }

  registerMember() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Set loading state to true
      });
      int matricule = await DatabaseMethods().getNextMatricule();

      String id = randomAlphaNumeric(10);
      Map<String, dynamic> memberInfo = {
        "prenom": prenomController.text,
        "nom": nomController.text,
        "telephone": telephoneController.text,
        "email": emailController.text,
        "poste": posteController.text,
        "id": id,
        "matricule": matricule.toString(),
      };

      bool response = await DatabaseMethods().addMember(memberInfo, id);
      setState(() {
        isLoading = false; // Set loading state to false after operation
      });
      if (response) {
        showScaffoldMessage(
          context: context,
          message: "Le Membre a été inscrit avec succès.",
          title: "Inscription Réussie",
          icondata: Icons.check,
          textColor: Colors.white,
          backColor: CustomStyle.secondColor,
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                    initialIndex: 0,
                  )),
          (Route<dynamic> route) => false,
        );
      } else {
        showScaffoldMessage(
          context: context,
          message: "Ce membre existe dejà dans la base de données ",
          title: "Membre Existant",
          icondata: Icons.check,
          textColor: Colors.white,
          backColor: CustomStyle.erroColor,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            color: CustomStyle.mainColor,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFieldColumn(
                title: "Prénom",
                customtextfield: CustomTextFormField(
                  keyboardType: TextInputType.name,
                  controller: prenomController,
                  hintText: 'Ex:Mamadou',
                  validator: (String? value) =>
                      Validations.emptyValidation(value),
                ),
              ),
              CustomTextFieldColumn(
                title: "Nom",
                customtextfield: CustomTextFormField(
                  keyboardType: TextInputType.name,
                  controller: nomController,
                  hintText: 'Ex:Condé',
                  validator: (String? value) =>
                      Validations.emptyValidation(value),
                ),
              ),
              CustomTextFieldColumn(
                title: "Téléphone",
                customtextfield: CustomTextFormField(
                  keyboardType: TextInputType.number,
                  controller: telephoneController,
                  hintText: 'Ex: 622222222',
                  /*validator: (String? value) =>
                                    Validations.contactNumberValidation(value),*/
                ),
              ),
              CustomTextFieldColumn(
                title: "Email",
                customtextfield: CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: 'Ex: mamadouconde@gmail.com',
                  validator: (String? value) =>
                      Validations.emailValidation(value),
                ),
              ),
              CustomTextFieldColumn(
                title: "Poste",
                customtextfield: CustomTextFormField(
                  keyboardType: TextInputType.name,
                  controller: posteController,
                  hintText: 'Ex: Sécrétaire Générale',
                  validator: (String? value) =>
                      Validations.emptyValidation(value),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  registerMember();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        CustomStyle.secondColor,
                        CustomStyle.mainColor,
                      ],
                    ),
                  ),
                  child: Center(
                    child: isLoading // Check loading state
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Ajouter le membre",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      /*Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.35,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: CustomStyle.mainColor),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                      )
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: selectImage != null
                          ? FileImage(selectImage!)
                          : const AssetImage("assets/images/medecin_2.jpg")
                              as ImageProvider,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      pickImageFromGallery();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.07,
                      width: MediaQuery.of(context).size.width * 0.07,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.white),
                        color: CustomStyle.mainColor,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )*/
    );
  }
}
