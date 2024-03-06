import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lecon extends StatelessWidget {
  final String imagePath;
  final String leconTitle;

  Lecon({required this.imagePath, required this.leconTitle});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 50,
      width: screenWidth,
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 40,
            width: 40,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                leconTitle,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
