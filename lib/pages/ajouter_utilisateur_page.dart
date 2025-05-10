import 'package:flutter/material.dart';
import '../models/utilisateur.dart';
import '../services/api_service.dart'; // Assurez-vous que cette méthode existe

class AjouterUtilisateurPage extends StatefulWidget {
     final int hopitalId;
    AjouterUtilisateurPage({required this.hopitalId});

  @override
  _AjouterUtilisateurPageState createState() => _AjouterUtilisateurPageState();
}

class _AjouterUtilisateurPageState extends State<AjouterUtilisateurPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController cinController = TextEditingController();
  final TextEditingController dateNaissanceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController assuranceController = TextEditingController();

  String? role;
  String? specialiteMedecin;
  String? specialiteInfermier;

  final List<String> roles = ['MEDECIN', 'INFIRMIER'];
  final List<String> specialitesMedecin = ['GENERALISTE', 'CARDIOLOGUE', 'DERMATOLOGUE'];
  final List<String> specialitesInfermier = ['URGENCE', 'PEDIATRIE', 'CHIRURGIE'];

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        Utilisateur utilisateur = Utilisateur(
          nom: nomController.text,
          prenom: prenomController.text,
          cin: cinController.text,
          dateNaissance: dateNaissanceController.text,
          email: emailController.text,
          telephone: telephoneController.text,
          adresse: adresseController.text,
          assuranceSocial: assuranceController.text,
          role: role!,
          specialiteMedecin: role == 'MEDECIN' ? specialiteMedecin : null,
          specialiteInfermier: role == 'INFIRMIER' ? specialiteInfermier : null,
        );

        final success = await ApiService.ajouterUtilisateur(utilisateur);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Utilisateur ajouté avec succès')));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Échec de l\'ajout')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter Utilisateur')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: nomController, decoration: InputDecoration(labelText: 'Nom'), validator: _notEmpty),
              TextFormField(controller: prenomController, decoration: InputDecoration(labelText: 'Prénom'), validator: _notEmpty),
              TextFormField(controller: cinController, decoration: InputDecoration(labelText: 'CIN'), validator: _notEmpty),
              TextFormField(controller: dateNaissanceController, decoration: InputDecoration(labelText: 'Date de Naissance (YYYY-MM-DD)'), validator: _notEmpty),
              TextFormField(controller: emailController, decoration: InputDecoration(labelText: 'Email'), validator: _notEmpty),
              TextFormField(controller: telephoneController, decoration: InputDecoration(labelText: 'Téléphone'), validator: _notEmpty),
              TextFormField(controller: adresseController, decoration: InputDecoration(labelText: 'Adresse'), validator: _notEmpty),
              TextFormField(controller: assuranceController, decoration: InputDecoration(labelText: 'Assurance Sociale'), validator: _notEmpty),
              DropdownButtonFormField<String>(
                value: role,
                hint: Text('Sélectionner le rôle'),
                onChanged: (val) => setState(() => role = val),
                validator: (val) => val == null ? 'Veuillez choisir un rôle' : null,
                items: roles.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              ),
              if (role == 'MEDECIN')
                DropdownButtonFormField<String>(
                  value: specialiteMedecin,
                  hint: Text('Spécialité Médecin'),
                  onChanged: (val) => setState(() => specialiteMedecin = val),
                  validator: (val) => val == null ? 'Spécialité requise' : null,
                  items: specialitesMedecin.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                ),
              if (role == 'INFIRMIER')
                DropdownButtonFormField<String>(
                  value: specialiteInfermier,
                  hint: Text('Spécialité Infirmier'),
                  onChanged: (val) => setState(() => specialiteInfermier = val),
                  validator: (val) => val == null ? 'Spécialité requise' : null,
                  items: specialitesInfermier.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text('Ajouter')),
            ],
          ),
        ),
      ),
    );
  }

  String? _notEmpty(String? value) => value == null || value.isEmpty ? 'Ce champ est requis' : null;
}
