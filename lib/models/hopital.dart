class Hopital {
  final int? id;
  final String nom;
  final String adresse;
  final String region;
  final String? province;
  final String? prefecture;

  Hopital({
    this.id,
    required this.nom,
    required this.adresse,
    required this.region,
    this.province,
    this.prefecture,
  });

  factory Hopital.fromJson(Map<String, dynamic> json) {
    return Hopital(
      id: json['idHopital'],
      nom: json['nom'],
      adresse: json['adresse'],
      region: json['region'],
      province: json['province'],
      prefecture: json['prefecture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'adresse': adresse,
      'region': region,
      'province': province,
      'prefecture': prefecture,
    };
  }
}
