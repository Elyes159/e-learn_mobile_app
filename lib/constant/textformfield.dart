import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final bool isPassword;

  const CustomTextForm({
    super.key,
    required this.hinttext,
    required this.mycontroller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: mycontroller,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[500]),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20), // Ajustez la valeur de vertical selon vos besoins
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Color(0xFF3DB2FF),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Color(0xFF3DB2FF),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
