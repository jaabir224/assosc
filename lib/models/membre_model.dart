class MembreModel {
  final String id;
  final String nom;
  final String prenom;
  final String telephone;
  final String email;
  final String poste;

  MembreModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.poste,
    required this.telephone,
  });

  // Méthode pour créer une instance de MembreModel à partir d'une map de données
  factory MembreModel.fromMap(Map<String, dynamic> data) {
    return MembreModel(
      id: data['id'] as String,
      nom: data['nom'] as String,
      prenom: data['prenom'] as String,
      email: data['email'] as String,
      poste: data['poste'] as String,
      telephone: data['telephone'] as String,
    );
  }
}
