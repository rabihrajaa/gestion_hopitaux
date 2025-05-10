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
  'https://i-df.unimedias.fr/2018/09/19/hopital.jpg?auto=format%2Ccompress&cs=tinysrgb&h=630&w=1200',
  'https://cdn-s-www.ledauphine.com/images/5DE98732-C3BC-42DE-BDAF-4959A87B37C5/NW_raw/le-centre-hospitalier-de-gap-a-vecu-un-lundi-de-paques-particulierement-complique-archives-photo-le-dl-gerald-lucas-1650378617.jpg',
  'https://media.ouest-france.fr/v1/pictures/MjAyMDA1MjE4YWRlYzNkMmRjODYwMmI3NWI4MmYyZWE2ZDhhMGM?width=1260&height=708&focuspoint=72%2C36&cropresize=1&client_id=bpeditorial&sign=9bb9b5cf27c70b711c66c4c65e54835f06f520ffbbf25b9b5792293df6ba14c5',
  'https://www.letelegramme.fr/images/2020/08/11/les-urgences-de-l-hopital-de-saint-brieuc-enregistrent-une_5258754.jpg',
  'https://cdn-s-www.leprogres.fr/images/D601F080-C3C2-48CA-A5F0-C4C01422320C/FB1200/photo-1629303592.jpg',
  'https://media.ouest-france.fr/v1/pictures/MjAyMDA1MjE4YWRlYzNkMmRjODYwMmI3NWI4MmYyZWE2ZDhhMGM?width=1260&height=708&focuspoint=72%2C36&cropresize=1&client_id=bpeditorial&sign=9bb9b5cf27c70b711c66c4c65e54835f06f520ffbbf25b9b5792293df6ba14c5'
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
