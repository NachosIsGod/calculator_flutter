import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutterproject/components/rect_button.dart';
import 'package:flutterproject/components/icon_button.dart';
import 'components/display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<StatefulWidget> {

  String displayText = '0';
  String result = '';
  String operator = '0';

  _MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('cal'),
        ),
        body: Center(
          child: SizedBox(
            width: 320,
            height: 480,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(4), //角丸くする
              ),
                child: Column( //縦に並べる
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Display(displayText),
                    ),

                    Row(//横に並べる
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        createAllClearButton(),
                        createExponentiationButton(),
                        createPlusOrMinusButton(),
                        createBackSpaceButton(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        createButton('7',true),
                        createButton('8',true),
                        createButton('9',true),
                        createOperatorButton('+')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        createButton('4',true),
                        createButton('5',true),
                        createButton('6',true),
                        createOperatorButton('-')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        createButton('1',true),
                        createButton('2',true),
                        createButton('3',true),
                        createOperatorButton('×')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        createDotButton(),
                        createButton('0',true),
                        createOperatorButton('='),
                        createOperatorButton('÷')
                      ],
                    ),
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createButton(String name, bool isRound){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RectButton(name, isRound, (){
        print('やっほー  $name');

        //画面変更するときはsetStateで囲う
        setState(() {


          if(displayText == '0') displayText = '';
          displayText += name;
        });
      }),
    );
  }

  Widget createDotButton(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RectButton('.', false, (){
        print('やっほー  .');

        //画面変更するときはsetStateで囲う
        setState(() {
          if(!displayText.contains('.')) {
            displayText += '.';
            if (displayText == '.') displayText = '0.';
          }
        });
      }),
    );
  }

  Widget createAllClearButton () {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RectButton('AC', false, (){
        print('やっほー  AC');

        //画面変更するときはsetStateで囲う
        setState(() {
          displayText = '0';
          result = '';
          operator = '0';
        });

      }),
    );
  }

  Widget createBackSpaceButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Icon_Button(icon:const Icon(Icons.backspace), isRound:false, onTap:(){
        print('やっほー  backspace');

        //画面変更するときはsetStateで囲う
        setState(() {
          displayText = displayText.substring(0, displayText.length-1);
        });
      }),
    );
  }

  Widget createPlusOrMinusButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RectButton('+/-', false, (){
        print('hello  +/-');

        //画面変更するときはsetStateで囲う
        setState(() {
          if(displayText.substring(0,1) == '-'){
            displayText = displayText.substring(1,displayText.length);
          }else{
            displayText = '-' + displayText;
          }
        });
      }),
    );
  }

  Widget createExponentiationButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RectButton('x²', false, (){
        print('やっほー  x²');

        //画面変更するときはsetStateで囲う
        setState(() {
          displayText = (int.parse(displayText) * int.parse(displayText)).toString();
        });
      }),
    );
  }

  Widget createOperatorButton(String name) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RectButton(name, false, (){
        print('やっほー  $name');

        //画面変更するときはsetStateで囲う
        setState(() {
          if(name == '+'){
            result = result.isNotEmpty? calculate(result, operator, displayText): displayText;
            operator = '+';
            displayText = '';

          }else if(name == '-'){
            result = result.isNotEmpty? calculate(result, operator, displayText): displayText;
            operator = '+';
            displayText = '';

          }else if(name == '×'){
            result = result.isNotEmpty? calculate(result, operator, displayText): displayText;
            operator = '+';
            displayText = '';

          }else if(name == '÷'){
            result = result.isNotEmpty? calculate(result, operator, displayText): displayText;
            operator = '+';
            displayText = '';

          }else if(name == '='){
            result = result.isNotEmpty? calculate(result, operator, displayText): displayText;
            operator = '=';
            displayText = '';
          }else {
            displayText = result;
          }

        });
      }),
    );
  }
}

String calculate(String left, String op, String right) {

  String fl = left.contains('.')? (left.substring(left.indexOf('.')+1, left.length)): '0'; //右に点が無いときの処理
  String fr = right.contains('.')? (right.substring(right.indexOf('.')+1, right.length)): '0'; //右に点が無いときの処理

  print ('fl1 =' + fl);
  print ('fr1 =' + fr);

  //桁数合わせ
  if(fl.length < fr.length){
    while(fl.length != fr.length){
      fl += '0';
    }
  }else if(fl.length > fr.length){
    while(fl.length != fr.length){
      fr += '0';
    }
  }

  print ('fl2 =' + fl);
  print ('fr2 =' + fr);


  int il = left.contains('.')? int.parse(left.substring(0, left.indexOf('.'))): int.parse(left);
  int ir = right.contains('.')? int.parse(right.substring(0, right.indexOf('.'))): int.parse(right);

  print ('il =' + il.toString());
  print ('ir =' + ir.toString());


  //少数の桁
  int l = fl.length;
  int len = 1;
  for(int i=0; i<l; i++){
    len *= 10;
  }

  int f = 0;
  int i = 0;
  if(op == '+') {
    f = int.parse(fl) + int.parse(fr);
    i = il + ir + f ~/ len;

  }
  if(op == '-') {

  }
  if(op == '×') {

  }
  if(op == '÷') {

  }

  print( f==0? i.toString() : i.toString() + '.' + f.toString());
  return f==0? i.toString() : i.toString() + '.' + f.toString();
}