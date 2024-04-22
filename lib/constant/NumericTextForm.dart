import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;

  const NumericTextForm({
    Key? key,
    required this.hinttext,
    required this.mycontroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        // Vous pouvez ajouter d'autres formateurs si nécessaire
      ],
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
