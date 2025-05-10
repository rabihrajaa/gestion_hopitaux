class Utilisateur {
  final int? id;
  final String nom;
  final String prenom;
  final String cin;
  final String dateNaissance;
  final String email;
  final String telephone;
  final String adresse;
  final String assuranceSocial;
  final String role;
  final String? specialiteMedecin;
  final String? specialiteInfermier;

  Utilisateur({
    this.id,
    required this.nom,
    required this.prenom,
    required this.cin,
    required this.dateNaissance,
    required this.email,
    required this.telephone,
    required this.adresse,
    required this.assuranceSocial,
    required this.role,
    this.specialiteMedecin,
    this.specialiteInfermier,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['idUtilisateur'],
      nom: json['nom'],
      prenom: json['prenom'],
      cin: json['cin'],
      dateNaissance: json['dateNaissance'],
      email: json['email'],
      telephone: json['telephone'],
      adresse: json['adresse'],
      assuranceSocial: json['assuranceSocial'],
      role: json['role'],
      specialiteMedecin: json['specialiteMedecin'],
      specialiteInfermier: json['specialiteInfermier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'cin': cin,
      'dateNaissance': dateNaissance,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,
      'assuranceSocial': assuranceSocial,
      'role': role,
      'specialiteMedecin': specialiteMedecin,
      'specialiteInfermier': specialiteInfermier,
    };
  }
}
