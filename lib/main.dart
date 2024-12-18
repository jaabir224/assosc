import 'package:assosc/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'providers/member_provider.dart';
import 'vue/add_user/add_user.dart';
import 'vue/add_year/add_year.dart';
import 'vue/choice_add/choice_add.dart';
import 'vue/detail_membre/detail_membre.dart';
import 'vue/home/home.dart';
import 'vue/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MemberProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assosc',
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Charge l'interface pendant l'attente
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Home(); // Utilisateur connecté, redirige vers la page Home
            } else {
              return const Login(); // Utilisateur non connecté, redirige vers la page Login
            }
          },
        ),
        routes: {
          Home.path: (context) => Home(),
          Login.path: (context) => const Login(),
          AddUser.path: (context) => const AddUser(),
          ChoiceAdd.path: (context) => const ChoiceAdd(),
          AddYear.path: (context) => const AddYear(),
          DetailMembre.path: (context) => const DetailMembre(),
        },
      ),
    );
  }
}
