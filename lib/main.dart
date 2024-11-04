import 'package:assosc/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'providers/member_provider.dart';
import 'vue/add_user/add_user.dart';
import 'vue/add_year/add_year.dart';
import 'vue/choice_add/choice_add.dart';
import 'vue/detail_patient/detail_membre.dart';
import 'vue/home/home.dart';
import 'vue/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        home: const Home(),
        routes: {
          Home.path: (context) => const Home(),
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
