import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? currentUser;
  String? username;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Récupérer l'ID de l'utilisateur actuel
      String uid = user.uid;
      print(uid);
      // Utiliser l'ID pour récupérer les données de l'utilisateur depuis Firestore
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Extraire le champ "username" du snapshot
      if (userSnapshot.exists) {
        username = userSnapshot['username'];
        print("ahawwa");
      } else {
        print("not exsit");
      }
    }

    setState(() {
      currentUser = user;
    });
  }

  void navigateToHome() {
    // Mettez ici la logique de navigation pour l'onglet Accueil
    print("Naviguer vers Accueil");
  }

  void navigateToSearch() {
    // Mettez ici la logique de navigation pour l'onglet Recherche
    print("Naviguer vers Recherche");
  }

  void navigateToSettings() {
    // Mettez ici la logique de navigation pour l'onglet Paramètres
    print("Naviguer vers Paramètres");
  }

  @override
  Widget build(BuildContext context) {
    final User? user1 = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF3DB2FF),
            ),
            height: 250, // Ajustez la hauteur comme nécessaire
            // Couleur bleue
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100, left: 0),
                      child: Text(
                        'Hi, ${username ?? "Nom inconnu"}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "What language",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "would you like to learn?",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 30),
                  child: Image.asset(
                    "assets/languages.png",
                    height: 130,
                    width: 130,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                child: ListView(
              children: [
                Center(
                    child: Text(
                  "Language Being Learned",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600),
                )),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.grey, // Couleur de la bordure
                        width: 2.0, // Épaisseur de la bordure
                      ),
                    ),
                    width: 165,
                    height: 93,
                  ),
                )
              ],
            )),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // Utilisez BottomNavigationBarType.fixed
        currentIndex: _currentIndex,
        onTap: (index) {
          // Ajoutez ici la logique de navigation en fonction de l'index
          // Par exemple, Navigator.push, Navigator.pop, etc.
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.book,
              color: Color(0xFF3DB2FF),
            ),
            label: "Learn",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.search,
              color: Color(0xFF3DB2FF),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.trophy,
              color: Color(0xFF3DB2FF),
            ),
            label: 'Achievement',
          ),
          // Ajoutez les éléments supplémentaires ici
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.person,
              color: Color(0xFF3DB2FF),
            ),
            label: 'Profile',
          ),

          // Ajoutez d'autres éléments si nécessaire
        ],

        selectedLabelStyle: GoogleFonts.poppins(),
        unselectedLabelStyle: GoogleFonts.poppins(),
      ),
    );
  }
}
