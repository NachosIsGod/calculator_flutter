
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Display extends StatelessWidget{

  String text;

  Display(this.text);

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
          text,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 48),
          maxLines: 1,
        ),
      ),
    );
  }

}