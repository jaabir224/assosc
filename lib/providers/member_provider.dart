import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/membre_model.dart';
import '../services/database.dart';

class MemberProvider extends ChangeNotifier {
  List<MembreModel> _members = [];

  List<MembreModel> get members => _members;

  MemberProvider() {
    getMembers();
  }

  Future<void> getMembers() async {
    try {
      DatabaseMethods().getMembers().then((memberStream) {
        memberStream.listen((QuerySnapshot snapshot) {
          _members = snapshot.docs.map((doc) {
            return MembreModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          notifyListeners();
        });
      });
    } catch (e) {
      print("Erreur lors de la récupération des membres : $e");
    }

    print(_members.length);
  }
}
