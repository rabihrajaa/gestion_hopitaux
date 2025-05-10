import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/ajouter_hopital_page.dart';
import 'pages/utilisateurs_page.dart'; // Assurez-vous d'importer la bonne page

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
  int _hopitalId=2;

  final List<Widget> _pages = [
    HomePage(),
    AjouterHopitalPage(),
    SizedBox.shrink(), // Placeholder for navigation via hopitalId
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 2
          ? UtilisateursPage(hopitalId: _hopitalId!)
          : _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'Ajouter Hôpital'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Liste utilisateurs'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;

            // Redirection vers UtilisateursPage seulement si hopitalId est défini
            if (index == 2 && _hopitalId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Veuillez d\'abord sélectionner un hôpital')),
              );
              _currentIndex = 0; // Retour à la page d'accueil
            }
          });
        },
      ),
    );
  }

  // Pour permettre à une autre page de définir l'ID d'hôpital sélectionné
  void setHopitalId(int hopitalId) {
    setState(() {
      _hopitalId = hopitalId;
    });
  }
}
