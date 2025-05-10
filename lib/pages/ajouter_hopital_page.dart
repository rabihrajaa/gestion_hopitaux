import 'package:flutter/material.dart';
import '../models/hopital.dart';
import '../services/api_service.dart';
import 'home_page.dart';
class AjouterHopitalPage extends StatefulWidget {
  
  @override
  _AjouterHopitalPageState createState() => _AjouterHopitalPageState();
}

class _AjouterHopitalPageState extends State<AjouterHopitalPage> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final adresseController = TextEditingController();
  final regionController = TextEditingController();
  final provinceController = TextEditingController();
  final prefectureController = TextEditingController();

void _submit() async {
  if (_formKey.currentState!.validate()) {
    Hopital hopital = Hopital(
      nom: nomController.text,
      adresse: adresseController.text,
      region: regionController.text,
      province: provinceController.text!=null?provinceController.text:null,
      prefecture: null ,
    );

    try {
      // Créer une instance de ApiService
      ApiService apiService = ApiService();

      // Appeler la méthode ajouterHopital sur l'instance
      await apiService.ajouterHopital(hopital);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hôpital ajouté avec succès')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'ajout : $e')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter un Hôpital')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: nomController, decoration: InputDecoration(labelText: 'Nom'), validator: (val) => val!.isEmpty ? 'Requis' : null),
              TextFormField(controller: adresseController, decoration: InputDecoration(labelText: 'Adresse'), validator: (val) => val!.isEmpty ? 'Requis' : null),
              TextFormField(controller: regionController, decoration: InputDecoration(labelText: 'Région'), validator: (val) => val!.isEmpty ? 'Requis' : null),
              TextFormField(controller: provinceController, decoration: InputDecoration(labelText: 'Province')),
              TextFormField(controller: prefectureController, decoration: InputDecoration(labelText: 'Préfecture')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text('Ajouter')),
            ],
          ),
        ),
      ),
    );
  }
}
