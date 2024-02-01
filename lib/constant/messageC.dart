import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String sender;
  final String text;

  MessageWidget(this.sender, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(text),
        ],
      ),
    );
  }
}
