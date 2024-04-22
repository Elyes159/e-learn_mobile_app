import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_1/starting/signin.dart';
import 'package:pfe_1/starting/signup.dart';

class Signup1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              // Partie haute de la page avec l'image en arrière-plan
              Image.asset(
                "assets/blue.png", // Remplacez "votre_image.jpg" par le chemin de votre image
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit
                    .cover, // Assurez-vous que l'image couvre tout l'espace disponible
              ),

              // Footer de la partie haute (en cercle)
              Positioned(
                bottom: 50,
                left: 10,
                right: 10,
                child: Image.asset("assets/tofla.png"),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Create Your Profile ",
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Now ! ",
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Create a profile to save your learning",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "progress and keep learning for free!",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              MaterialButton(
                onPressed: () {
                  // Utilisez Navigator pour retourner à la page précédente
                  Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Login()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    "Back",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3DB2FF),
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  // Utilisez Navigator pour retourner à la page précédente
                  Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Signup(),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 100.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3DB2FF),
                      borderRadius: BorderRadius.circular(
                          8.0), // Ajustez le rayon selon vos besoins
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Next",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
