import 'dart:io';
import 'package:custom_text_form_field_plus/custom_text_form_field_plus.dart';
import 'package:flutter/material.dart';
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
      String id = randomAlphaNumeric(10);
      Map<String, dynamic> memberInfo = {
        "prenom": prenomController.text,
        "nom": nomController.text,
        "telephone": telephoneController.text,
        "email": emailController.text,
        "poste": posteController.text,
        "id": id,
      };

      await DatabaseMethods().addMember(memberInfo, id).then((onValue) {
        showScaffoldMessage(
          // ignore: use_build_context_synchronously
          context: context,
          message: "Le Membre a été inscrit avec succès.",
          title: "Inscription Réussie",
          icondata: Icons.check,
          textColor: Colors.white,
          backColor: CustomStyle.secondColor,
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          (Route<dynamic> route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomStyle.mainColor,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.08,
                      ),
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
                                validator: (String? value) =>
                                    Validations.contactNumberValidation(value),
                              ),
                            ),
                            CustomTextFieldColumn(
                              title: "Email",
                              customtextfield: CustomTextFormField(
                                keyboardType: TextInputType.name,
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
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                registerMember();
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.055,
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
                                child: const Center(
                                  child: Text(
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
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
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
          )
        ],
      ),
    );
  }
}
