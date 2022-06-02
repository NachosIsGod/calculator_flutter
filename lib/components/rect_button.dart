import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RectButton extends StatelessWidget {
  String name;
  bool isRound;
  GestureTapCallback onTap;

  RectButton(this.name, this.isRound, this.onTap);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      //押されたら処理
      onTap: onTap,

      child: SizedBox(
        width: 66,
        height: 66,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(isRound?16:0), //角丸くする
          ),
          child: Center(child: Text(
            name,
            style: const TextStyle(fontSize: 24),
          )),
        ),
      ),
    );
  }
}