import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lecon extends StatelessWidget {
  final String imagePath;
  final String leconTitle;
  final String navigator;

  Lecon(
      {required this.imagePath,
      required this.leconTitle,
      required this.navigator});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(navigator);
      },
      child: Container(
        height: 60,
        width: screenWidth,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8), // Ajoutez cet espacement
            Text(
              leconTitle,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
