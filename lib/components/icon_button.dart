import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Icon_Button extends StatelessWidget {
  final Icon icon;
  final bool isRound;
  final GestureTapCallback onTap;

  const Icon_Button({Key? key, required this.icon, required this.isRound, required this.onTap}) : super(key: key);//波かっこは入れても入れなくてもいい(?をつける）

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
          child: Center(
              child: icon
          ),
        ),
      ),
    );
  }
}