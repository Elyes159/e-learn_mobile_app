import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final bool isPassword;

  const CustomTextForm({
    Key? key,
    required this.hinttext,
    required this.mycontroller,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: mycontroller,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
        contentPadding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20), // Ajustez la valeur de vertical selon vos besoins
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Color(0xFF3DB2FF),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Color(0xFF3DB2FF),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
