import 'package:flutter/material.dart';

class Admin_main extends StatefulWidget {
  @override
  _Admin_mainState createState() => _Admin_mainState();
}

class _Admin_mainState extends State<Admin_main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("addQuestionPage");
                },
                child: Text("ajouter des question , cliquer ici")),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("usersPage");
                },
                child: Text("Gérer les utilisateurs  , cliquer ici")),
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed("AddLeconFromAdmin");
                },
                child: Text("Ajouter des lecon   , cliquer ici"))
          ],
        ),
      ),
    );
  }
}
