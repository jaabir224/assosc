import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cotisation_model.dart';
import '../models/membre_model.dart';
import '../models/simple_cotisation_model.dart';

class DatabaseMethods {
  Future<bool> addMember(Map<String, dynamic> memberMap, String id) async {
  try {
    // Vérification si un membre avec le même email et téléphone existe déjà
    QuerySnapshot existingMemberSnapshot = await FirebaseFirestore.instance
        .collection("Membre")
        .where("email", isEqualTo: memberMap['email'])
        .where("telephone", isEqualTo: memberMap['telephone'])
        .get();

    // Si un membre avec le même email et téléphone existe déjà, retourner false
    if (existingMemberSnapshot.docs.isNotEmpty) {
      return false;
    }

    // Ajouter le membre dans la collection "Membre"
    await FirebaseFirestore.instance
        .collection("Membre")
        .doc(id)
        .set(memberMap);

    // Récupérer les années existantes
    QuerySnapshot yearsSnapshot =
        await FirebaseFirestore.instance.collection("annees").get();

    // Ajouter les cotisations pour chaque année
    for (var yearDoc in yearsSnapshot.docs) {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection("Cotisations").add({
        'membreId': id,
        'annee': yearDoc['annee'],
        'isPaid': false,
      });
      await docRef.update({'id': docRef.id});
    }

    // Si tout est ok, retourner true
    return true;
  } catch (e) {
    print("Erreur lors de l'ajout du membre : $e");
    return false;
  }
}


  Future<Stream<QuerySnapshot>> getMembers() async {
    return FirebaseFirestore.instance.collection("Membre").snapshots();
  }

  Future<bool> addYear(Map<String, dynamic> anneMap) async {
    try {
      // Vérification de l'existence de l'année dans la collection "annees"
      QuerySnapshot existingYearSnapshot = await FirebaseFirestore.instance
          .collection("annees")
          .where("annee", isEqualTo: anneMap['annee'])
          .get();

      // Si une année identique existe déjà, on retourne false
      if (existingYearSnapshot.docs.isNotEmpty) {
        return false;
      }

      // Ajout de l'année dans la collection "annees"
      await FirebaseFirestore.instance.collection("annees").add(anneMap);

      // Ajout des cotisations pour tous les membres existants
      QuerySnapshot membersSnapshot =
          await FirebaseFirestore.instance.collection("Membre").get();

      for (var memberDoc in membersSnapshot.docs) {
        DocumentReference docRef =
            await FirebaseFirestore.instance.collection("Cotisations").add({
          'membreId': memberDoc.id,
          'annee': anneMap['annee'],
          'isPaid': false,
        });
        await docRef.update({'id': docRef.id});
      }

      return true;
    } catch (e) {
      print("Erreur lors de l'ajout de l'année : $e");
      return false;
    }
  }

  Future<List<CotisationModel>> getCotisationsWithMembers() async {
    try {
      QuerySnapshot cotisationsSnapshot =
          await FirebaseFirestore.instance.collection("Cotisations").get();

      QuerySnapshot membersSnapshot =
          await FirebaseFirestore.instance.collection("Membre").get();

      // Création d'une map pour retrouver rapidement les informations des membres
      Map<String, MembreModel> membersMap = {
        for (var doc in membersSnapshot.docs)
          doc.id: MembreModel.fromMap(doc.data() as Map<String, dynamic>)
      };

      List<CotisationModel> cotisationsWithMembers = [];

      for (var cotisationDoc in cotisationsSnapshot.docs) {
        var cotisationData = cotisationDoc.data() as Map<String, dynamic>;

        // Vérifie que l'ID est bien défini pour chaque cotisation
        if (cotisationData.containsKey('id') && cotisationData['id'] != null) {
          var membreId = cotisationData['membreId'];

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
              id: cotisationData['id'],
            ));
          }
        }
      }

      return cotisationsWithMembers;
    } catch (e) {
      print("Erreur lors de la récupération des cotisations avec membres : $e");
      return [];
    }
  }

  Future<void> updateCotisationToPaid({
    required String cotisationId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("Cotisations")
          .doc(cotisationId)
          .update({'isPaid': true});

      print("Cotisation mise à jour avec succès pour l'ID $cotisationId");
    } catch (e) {
      print("Erreur lors de la mise à jour de la cotisation : $e");
    }
  }

  Future<int> getNextMatricule() async {
    try {
      // Référence à la collection et au document
      DocumentReference matriculeDoc =
          FirebaseFirestore.instance.collection("Matricules").doc("last");

      // Tente de récupérer le dernier matricule
      DocumentSnapshot snapshot = await matriculeDoc.get();

      if (snapshot.exists) {
        // Si le document existe, incrémente le matricule
        int lastMatricule = snapshot['value'] as int;
        int newMatricule = lastMatricule + 1;

        // Met à jour la valeur dans Firestore
        await matriculeDoc.update({'value': newMatricule});

        return newMatricule;
      } else {
        // Si le document n'existe pas encore, initialise avec 1
        int initialMatricule = 1;
        await matriculeDoc.set({'value': initialMatricule});

        return initialMatricule;
      }
    } catch (e) {
      print("Erreur lors de la génération du matricule : $e");
      // Retourne une valeur par défaut en cas d'erreur
      return -1;
    }
  }

  Future<List<SimpleCotisationModel>> getCotisationsByMember(
      String membreId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("Cotisations")
          .where("membreId", isEqualTo: membreId)
          .get();

      List<SimpleCotisationModel> cotisations = snapshot.docs.map((doc) {
        return SimpleCotisationModel.fromMap(
            doc.data() as Map<String, dynamic>);
      }).toList();

      return cotisations;
    } catch (e) {
      print("Erreur lors de la récupération des cotisations : $e");
      return [];
    }
  }
}



 /*Future<void> addYear(Map<String, dynamic> anneMap) async {
    await FirebaseFirestore.instance.collection("annees").add(anneMap);

    QuerySnapshot membersSnapshot =
        await FirebaseFirestore.instance.collection("Membre").get();

    for (var memberDoc in membersSnapshot.docs) {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection("Cotisations").add({
        'membreId': memberDoc.id,
        'annee': anneMap['annee'],
        'isPaid': false,
      });
      await docRef.update({'id': docRef.id});
    }
  }*/