class CotisationModel {
  final String prenom, nom, telephone, email, membreId,id;
  final int annee;
  late bool isPaid;

  CotisationModel({
    required this.telephone,
    required this.annee,
    required this.nom,
    required this.email,
    required this.membreId,
    required this.prenom,
    required this.isPaid,
    required this.id,
  });

  factory CotisationModel.fromMap(Map<String, dynamic> data) {
    return CotisationModel(
      telephone: data['telephone'] as String? ?? '',
      annee: data['annee'] as int? ?? 0,
      nom: data['nom'] as String? ?? '',
      email: data['email'] as String? ?? '',
      membreId: data['membreId'] as String? ?? '',
      prenom: data['prenom'] as String? ?? '',
      id: data['id'] as String? ?? '',
      isPaid: data['isPaid'] as bool? ?? false,
    );
  }
}
