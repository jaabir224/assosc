import 'package:assosc/services/auth_services.dart';
import 'package:assosc/utils/app_message.dart';
import 'package:custom_text_form_field_plus/custom_text_form_field_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/CustomTextFieldColumn.dart';
import '../../utils/custom_style.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static String path = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isErrorLogin = false;

  signup() async {
    if (_formKey.currentState!.validate()) {
      bool response = await AuthServices().signIn(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response) {
        showScaffoldMessage(
          context: context,
          message: "Connexion réussie",
          title: "Bienvenue",
          icondata: FontAwesomeIcons.doorOpen,
          textColor: Colors.white,
          backColor: CustomStyle.secondColor,
        );
        setState(() {
            isErrorLogin = false;
        });
      } else {
        setState(() {
          isErrorLogin = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomStyle.mainColor,
      body: Form(
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
                  topLeft: Radius.circular(90),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        /* image: DecorationImage(
                            image: AssetImage(
                              "assets/images/aeemg.png",
                            ),
                            fit: BoxFit.cover),*/
                      ),
                    ),
                    CustomTextFieldColumn(
                      title: "Email",
                      customtextfield: CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        hintText: 'Enter votre eamil',
                        validator: (String? value) =>
                            Validations.emailValidation(value),
                      ),
                    ),
                    CustomTextFieldColumn(
                      title: "Mot de pass",
                      customtextfield: CustomTextFormField(
                        keyboardType: TextInputType.name,
                        controller: passwordController,
                        hintText: 'Enter votre mot de pass',
                        validator: (String? value) =>
                            Validations.emptyValidation(value),
                      ),
                    ),
                    if (isErrorLogin) ...{
                      Text(
                        "Email ou mot de pass invalide ",
                        style: TextStyle(
                          color: CustomStyle.erroColor,
                          fontSize: MediaQuery.of(context).size.width * 0.033,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    },
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () => signup(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.5,
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
                            "Connexion",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: CustomStyle.mainColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(90),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
