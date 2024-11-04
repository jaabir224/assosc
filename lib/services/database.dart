import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cotisation_model.dart';
import '../models/membre_model.dart';

class DatabaseMethods {
  // Ajoute un membre et crée des cotisations pour chaque année existante
  Future<void> addMember(Map<String, dynamic> memberMap, String id) async {
    // Ajout du membre
    await FirebaseFirestore.instance
        .collection("Membre")
        .doc(id)
        .set(memberMap);

    // Récupérer toutes les années existantes
    QuerySnapshot yearsSnapshot =
        await FirebaseFirestore.instance.collection("annees").get();

    // Création des cotisations pour chaque année existante
    for (var yearDoc in yearsSnapshot.docs) {
      await FirebaseFirestore.instance.collection("Cotisations").add({
        'membreId': id,
        'annee': yearDoc['annee'],
        'isPaid': false,
      });
    }
  }

  // Récupère tous les membres
  Future<Stream<QuerySnapshot>> getMembers() async {
    return FirebaseFirestore.instance.collection("Membre").snapshots();
  }

  // Ajoute une année et crée des cotisations pour tous les membres existants
  Future<void> addYear(Map<String, dynamic> anneMap) async {
    // Ajout de l'année
    await FirebaseFirestore.instance.collection("annees").add(anneMap);

    // Récupérer tous les membres existants
    QuerySnapshot membersSnapshot =
        await FirebaseFirestore.instance.collection("Membre").get();

    // Création d'une cotisation non payée pour chaque membre
    for (var memberDoc in membersSnapshot.docs) {
      await FirebaseFirestore.instance.collection("Cotisations").add({
        'membreId': memberDoc.id,
        'annee': anneMap[
            'annee'], // On suppose que `annee` est une clé dans `anneMap`
        'isPaid': false,
      });
    }
  }

  Future<List<CotisationModel>> getCotisationsWithMembers() async {
    try {
      // Récupérer les cotisations
      QuerySnapshot cotisationsSnapshot =
          await FirebaseFirestore.instance.collection("Cotisations").get();

      // Récupérer tous les membres
      QuerySnapshot membersSnapshot =
          await FirebaseFirestore.instance.collection("Membre").get();

      // Convertir les membres en un map pour un accès rapide
      Map<String, MembreModel> membersMap = {
        for (var doc in membersSnapshot.docs)
          doc.id: MembreModel.fromMap(doc.data() as Map<String, dynamic>)
      };

      List<CotisationModel> cotisationsWithMembers = [];

      // Associer chaque cotisation avec son membre
      for (var cotisationDoc in cotisationsSnapshot.docs) {
        var cotisationData = cotisationDoc.data() as Map<String, dynamic>;
        var membreId = cotisationData['membreId'];

        // Vérifier si le membre existe dans le map
        if (membersMap.containsKey(membreId)) {
          var member = membersMap[membreId]!;
          cotisationsWithMembers.add(CotisationModel(
            membreId: membreId,
            annee: cotisationData['annee'],
            isPaid: cotisationData['isPaid'],
            prenom: member.prenom,
            nom: member.nom,
            telephone: member.telephone,
            email: member.email,
          ));
        }
      }

      return cotisationsWithMembers;
    } catch (e) {
      print("Erreur lors de la récupération des cotisations avec membres : $e");
      return [];
    }
  }
}
