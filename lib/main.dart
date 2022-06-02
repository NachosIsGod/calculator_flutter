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

  //double? num1;
  //double? num2;
  double? answer = 0;
  int ASMD = 0;
  bool delete = true;

  int leftNum1 = 0;
  int rightNum1 = 0;
  int leftNum2 = 0;
  int rightNum2 = 0;

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
                        createButton('.',false),
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
          if(delete) displayText = '';
          displayText += name;
          if(displayText == '.')displayText = '0.';
          if(displayText != '0')delete = false;
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
          leftNum1 = 0;
          leftNum2 = 0;
          rightNum1 = 0;
          rightNum2 = 0;
          answer = null;
          displayText = '0';
          ASMD = 0;
          delete = true;
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

  Widget createOperatorButton(String name) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RectButton(name, false, (){
        print('やっほー  $name');

        //画面変更するときはsetStateで囲う
        setState(() {
          if(name == '+'){
            if(ASMD == 0) {
              int index = displayText.indexOf('.');
              if(index != -1) {
                leftNum1 = int.parse(displayText.substring(0, index));
                rightNum1 = int.parse(displayText.substring(index+1));
              }
              else{
                leftNum1 = int.parse(displayText);
                rightNum1 = 0;
              }

              ASMD = 1;
              delete = true;
            }else{
              equal(1);
            }

          }else if(name == '-'){
            if(ASMD == 0) {
              int index = displayText.indexOf('.');
              if(index != -1) {
                leftNum1 = int.parse(displayText.substring(0, index));
                rightNum1 = int.parse(displayText.substring(index+1));
              }
              else{
                leftNum1 = int.parse(displayText);
                rightNum1 = 0;
              }

              ASMD = 2;
              delete = true;
            }else{
              equal(2);
            }

          }else if(name == '×'){
            if(ASMD == 0) {
              int index = displayText.indexOf('.');
              if(index != -1) {
                leftNum1 = int.parse(displayText.substring(0, index));
                rightNum1 = int.parse(displayText.substring(index+1));
              }
              else{
                leftNum1 = int.parse(displayText);
                rightNum1 = 0;
              }

              ASMD = 3;
              delete = true;
            }else{
              equal(3);
            }

          }else if(name == '÷'){
            if(ASMD == 0) {
              int index = displayText.indexOf('.');
              if(index != -1) {
                leftNum1 = int.parse(displayText.substring(0, index));
                rightNum1 = int.parse(displayText.substring(index+1));
              }
              else{
                leftNum1 = int.parse(displayText);
                rightNum1 = 0;
              }

              ASMD = 4;
              delete = true;
            }else{
              equal(4);
            }

          }else if(name == '='){
            equal(0);
            ASMD = 0;
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

  void equal(int asmd) {
    leftNum2 = int.parse(displayText.substring(0, dotPos(displayText)));
    rightNum2 = int.parse(displayText.substring(dotPos(displayText) +1, displayText.length));
    print('dot');
    print('left1 = $leftNum1');
    print('left2 = $leftNum2');
    print('right1 = $rightNum1');
    print('right2 = $rightNum2');

    if(ASMD == 1)displayText = (leftNum1 + leftNum2).toString() + '.' + (rightNum1 + rightNum2).toString();
    if(ASMD == 2)displayText = (leftNum1 - leftNum2).toString() + '.' + (rightNum1 - rightNum2).toString();
    if(ASMD == 3)displayText = (leftNum1 * leftNum2).toString() + '.' + (rightNum1 * rightNum2).toString();
    if(ASMD == 4)displayText = (leftNum1 / leftNum2).toString() + '.' + (rightNum1 / rightNum2).toString();
    leftNum1 = int.parse(displayText.substring(0, dotPos(displayText)));
    rightNum1 = int.parse(displayText.substring(dotPos(displayText) +1, displayText.length));

    answer = double.parse(displayText);
    leftNum2 = 0;
    rightNum2 = 0;
    delete = true;
    ASMD = asmd;
  }

  int dotPos(String text) {
    int pos = text.indexOf('.');
    print ('pos = $pos');
    if(pos != -1){
      return(pos);
    }else{
      return(0);
    }
  }


}