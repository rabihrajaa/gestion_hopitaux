import 'package:flutter/material.dart';
import '../models/hopital.dart';
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

  // Images d'hôpitaux aléatoires depuis unsplash (liens publics)
  final List<String> hopitalImages = [
    'https://source.unsplash.com/400x200/?hospital',
    'https://source.unsplash.com/400x200/?clinic',
    'https://source.unsplash.com/400x200/?medical-center',
    'https://source.unsplash.com/400x200/?healthcare',
    'https://source.unsplash.com/400x200/?emergency-room',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste des Hôpitaux',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blue,
        elevation: 8,
        shadowColor: Colors.black54,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Hopital>>(
        future: _hopitaux,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final hopitaux = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: hopitaux.length,
              itemBuilder: (context, index) {
                final hopital = hopitaux[index];
                final imageUrl = hopitalImages[index % hopitalImages.length];
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AjouterUtilisateurPage(hopitalId: hopital.id!),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.network(imageUrl, height: 180, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hopital.nom,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                hopital.adresse,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
