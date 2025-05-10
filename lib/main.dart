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
  final List<Widget> _pages = [HomePage(), AjouterHopitalPage(), AjouterUtilisateurPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
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
          });
        },
      ),
    );
  }
}
