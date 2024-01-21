import 'package:flutter/material.dart';

class Customlogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 80,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset(
          "images/logo.png",
          height: 50,
          //fit: BoxFit.fill,
        ),
      ),
    );
  }
}
