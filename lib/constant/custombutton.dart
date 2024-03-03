import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importez Google Fonts

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const CustomButton({
    Key? key,
    this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: onPressed,
      color: Color(0xFF7885ff),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          // Utilisez GoogleFonts.poppins pour la police Poppins
          fontSize: 18, // Ajustez la taille de la police selon vos besoins
          fontWeight: FontWeight
              .w500, // Ajustez le poids de la police selon vos besoins
          color: Colors.white, // Couleur du texte
        ),
      ),
    );
  }
}
