import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/membre_model.dart';
import '../models/cotisation_model.dart';
import '../services/database.dart';

class MemberProvider extends ChangeNotifier {
  List<MembreModel> _members = [];
  List<CotisationModel> _cotisations = [];
  List<int> _years = [];
  List<CotisationModel> _filteredCotisations = [];

  List<MembreModel> get members => _members;
  List<CotisationModel> get cotisations => _cotisations;
  List<int> get years => _years;
  List<CotisationModel> get filteredCotisations => _filteredCotisations;

  MemberProvider() {
    getMembers();
    getCotisationsWithMembers();
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
  }

  Future<void> getCotisationsWithMembers() async {
    _cotisations = await DatabaseMethods().getCotisationsWithMembers();
    _filteredCotisations = List.from(_cotisations);
    _years =
        _cotisations.map((cotisation) => cotisation.annee).toSet().toList();

    // Trie les années de manière décroissante
    _years.sort((a, b) => b.compareTo(a));
    notifyListeners();
  }

  void filterCotisationsByYear(int year) {
    _filteredCotisations =
        _cotisations.where((cotisation) => cotisation.annee == year).toList();
    notifyListeners();
  }
}
