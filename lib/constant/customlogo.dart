import 'package:flutter/material.dart';

class Customlogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset(
          "images/logo.png",
          height: 100,
          //fit: BoxFit.fill,
        ),
      ),
    );
  }
}
