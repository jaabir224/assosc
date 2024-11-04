class CotisationModel {
  final String prenom, nom, telephone, email,membreId;
  final int  annee;
  late bool isPaid;

  CotisationModel({
    required this.telephone,
    required this.annee,
    required this.nom,
    required this.email,
    required this.membreId,
    required this.prenom,
    required this.isPaid,
  });

factory CotisationModel.fromMap(Map<String, dynamic> data) {
  return CotisationModel(
    telephone: data['telephone'] as String? ?? '', // Valeur par défaut
    annee: data['annee'] as int? ?? 0, // Valeur par défaut
    nom: data['nom'] as String? ?? '', // Valeur par défaut
    email: data['email'] as String? ?? '', // Valeur par défaut
    membreId: data['membreId'] as String? ?? '', // Assurez-vous que membreId est un String
    prenom: data['prenom'] as String? ?? '', // Valeur par défaut
    isPaid: data['isPaid'] as bool? ?? false, // Valeur par défaut
  );
}

}
