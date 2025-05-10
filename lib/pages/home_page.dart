import 'package:flutter/material.dart';
import '../models/hopital.dart';
import '../models/utilisateur.dart';
import '../services/api_service.dart';
import 'ajouter_utilisateur_page.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Hopital>> _hopitaux;

  @override
  void initState() {
    super.initState();
    _hopitaux = ApiService.fetchHopitaux();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des Hôpitaux')),
      body: FutureBuilder<List<Hopital>>(
        future: _hopitaux,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final hopitaux = snapshot.data!;
            return ListView.builder(
              itemCount: hopitaux.length,
              itemBuilder: (context, index) {
                final hopital = hopitaux[index];
                return ListTile(
                  title: Text(hopital.nom),
                  subtitle: Text(hopital.adresse),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => UtilisateursPage(hopitalId: hopital.id!),
                    ));
                  },
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

