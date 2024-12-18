class SimpleCotisationModel {
  final membreId, id;
  final int annee;
  late bool isPaid;

  SimpleCotisationModel({
    required this.annee,
    required this.membreId,
    required this.isPaid,
    required this.id,
  });

  factory SimpleCotisationModel.fromMap(Map<String, dynamic> data) {
    return SimpleCotisationModel(
      annee: data['annee'] as int? ?? 0,
      membreId: data['membreId'] as String? ?? '',
      id: data['id'] as String? ?? '',
      isPaid: data['isPaid'] as bool? ?? false,
    );
  }
}
