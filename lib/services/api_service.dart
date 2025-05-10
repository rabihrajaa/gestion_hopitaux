import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hopital.dart';
import '../models/utilisateur.dart';

class ApiService {
  static const baseUrl = 'http://localhost:8085';

  static Future<List<Hopital>> fetchHopitaux() async {
    final response = await http.get(Uri.parse('$baseUrl/hopitaux'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return data.map((e) => Hopital.fromJson(e)).toList();
    } else {
      throw Exception('Erreur de chargement des hôpitaux');
    }
  }


Future<bool> ajouterHopital(Hopital hopital) async {
  final url = Uri.parse('http://localhost:8085/hopitaux');
  
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "nom": hopital.nom,
        "adresse": hopital.adresse,
        "region": hopital.region,
        "province": hopital.province,
        "prefecture": hopital.prefecture,
      }),
    );
      print('Rajaa ${response.statusCode}: ${response.body}');
    if (response.statusCode == 201) {
      return true;
    } else {
      print('Erreur ${response.statusCode}: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Erreur lors de l\'ajout de l\'hôpital: $e');
    return false;
  }
}

 static Future<bool> ajouterUtilisateur(Utilisateur utilisateur) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/utilisateurs'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(utilisateur.toJson()),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  } catch (e) {
    print("Erreur d'ajout utilisateur: $e");
    return false;
  }
}


  static Future<List<Utilisateur>> fetchUtilisateursByHopital(int hopitalId) async {
    final response = await http.get(Uri.parse('$baseUrl/utilisateurs/hopital/$hopitalId'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return data.map((e) => Utilisateur.fromJson(e)).toList();
    } else {
      throw Exception('Erreur de chargement des utilisateurs');
    }
  }
}
