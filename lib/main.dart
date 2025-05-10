import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/ajouter_hopital_page.dart';
import 'pages/ajouter_utilisateur_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  // Pour garder la trace du hopitalId quand on passe à la page AjouterUtilisateurPage
  int? _hopitalId;

  final List<Widget> _pages = [
    HomePage(),
    AjouterHopitalPage(),
    // Tu n'ajoutes pas AjouterUtilisateurPage ici, tu vas le faire dans la navigation
    SizedBox.shrink(), // Utilisé comme un espace réservé
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 2 && _hopitalId != null
          ? AjouterUtilisateurPage(hopitalId: _hopitalId!) // On passe hopitalId ici
          : _pages[_currentIndex], // Les autres pages restent comme ça
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'Ajouter Hôpital'),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Ajouter Utilisateur'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;

            // Si on veut naviguer vers AjouterUtilisateurPage, on a besoin d'un hopitalId
            if (index == 2) {
              // Si on a un hopitalId, on navigue vers AjouterUtilisateurPage
              if (_hopitalId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AjouterUtilisateurPage(hopitalId: _hopitalId!),
                  ),
                );
              }
            }
          });
        },
      ),
    );
  }

  // On peut définir une méthode pour définir hopitalId et ensuite passer à la page AjouterUtilisateurPage
  void setHopitalId(int hopitalId) {
    setState(() {
      _hopitalId = hopitalId;
    });
  }
}
