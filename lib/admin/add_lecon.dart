import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLessonForm extends StatefulWidget {
  @override
  _AddLessonFormState createState() => _AddLessonFormState();
}

class _AddLessonFormState extends State<AddLessonForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void addLessonToFirebase() async {
    try {
      // Ajouter les données saisies dans le formulaire à Firebase
      await FirebaseFirestore.instance
          .collection('admin')
          .doc()
          .collection("lecons")
          .add({
        'title': titleController.text,
        'description': descriptionController.text,
      });
      // Effacer les champs du formulaire après l'ajout
      titleController.clear();
      descriptionController.clear();
    } catch (e) {
      // Gérer les erreurs éventuelles
      print('Erreur lors de l\'ajout de la leçon : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une leçon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'chapitre de la lecon'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'numero de la lecon'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: addLessonToFirebase,
              child: Text('Ajouter la leçon'),
            ),
          ],
        ),
      ),
    );
  }
}

class LessonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des leçons'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('lessons').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erreur : ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['title']),
                subtitle: Text(data['description']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
