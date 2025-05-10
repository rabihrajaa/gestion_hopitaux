import 'package:flutter/material.dart';
import '../models/utilisateur.dart';
import '../services/api_service.dart';

class UtilisateursPage extends StatelessWidget {
  final int hopitalId;

  UtilisateursPage({required this.hopitalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Utilisateurs")),
      body: FutureBuilder<List<Utilisateur>>(
        future: ApiService.fetchUtilisateursByHopital(hopitalId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final utilisateurs = snapshot.data!;
            return ListView.builder(
              itemCount: utilisateurs.length,
              itemBuilder: (context, index) {
                final u = utilisateurs[index];
                return ListTile(
                  title: Text('${u.nom} ${u.prenom}'),
                  subtitle: Text('${u.role} - ${u.specialiteMedecin ?? u.specialiteInfermier ?? 'N/A'}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
