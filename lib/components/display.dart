import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  Display({Key? key}) : super(key: key);

  @override
  DisplayState createState() => DisplayState();
}

class DisplayState extends State<Display> {
  String displayText = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          border: Border.all(color: Colors.white12),
        ),
        child: Text(
          displayText,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 48),
          maxLines: 1,
        ),
      ),
    );
  }
}
