class Hopital {
  final int id;
  final String nom;
  final String adresse;

  Hopital({required this.id, required this.nom, required this.adresse});

  factory Hopital.fromJson(Map<String, dynamic> json) {
    return Hopital(
      id: json['idHopital'],
      nom: json['nom'],
      adresse: json['adresse'],
    );
  }
}
