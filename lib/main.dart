import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutterproject/components/rect_button.dart';
import 'package:flutterproject/components/icon_button.dart';
import 'components/display.dart';
import 'package:intl/intl.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart'; // use rootBundle

final formatter = NumberFormat("#,###");
typedef OnClickFunction = void Function(String name);
Soundpool _pool = Soundpool(streamType: StreamType.notification);


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<StatefulWidget>{
  
  String result = '';
  String operator = '0';
  String inputText = '';
  int? tap;

  _MyApp();

  @override void initState() async{
    // TODO: implement initState
    super.initState();
    tap = await rootBundle.load("sounds/tap.mp3").then((ByteData soundData) {
    return _pool.load(soundData);
  });
  }



  @override
  Widget build(BuildContext context) {
    final displayKey = GlobalObjectKey<DisplayState>(context);

    // ignore: prefer_function_declarations_over_variables
    OnClickFunction numberClick = (name) {
      if (inputText == '0') inputText = '';
      inputText += name;
      displayKey.currentState?.displayText = numberFormat(inputText);
    };

    // ignore: prefer_function_declarations_over_variables
    OnClickFunction allClearClick = (name) {
      displayKey.currentState?.displayText = '0';
      inputText = '';
      result = '';
      operator = '0';
    };

    // ignore: prefer_function_declarations_over_variables
    OnClickFunction dotClick = (name) {
      if (!inputText.contains('.')) {
        inputText += '.';
        if (inputText == '.') inputText = '0.';
      }

      displayKey.currentState?.displayText = numberFormat(inputText);
    };

    // ignore: prefer_function_declarations_over_variables
    OnClickFunction plusminusClick = (name) {
      if (inputText.substring(0, 1) == '-') {
        inputText = inputText.substring(1, inputText.length);
      } else {
        inputText = '-' + inputText;
      }

      displayKey.currentState?.displayText = inputText;
    };

    // ignore: prefer_function_declarations_over_variables
    OnClickFunction exponentiationClick = (name) {
      inputText = (int.parse(inputText) * int.parse(inputText)).toString();

      displayKey.currentState?.displayText = inputText;
    };

    // ignore: prefer_function_declarations_over_variables
    OnClickFunction operatorClick = (name) {
      if (name == '+') {
        result = result.isNotEmpty
            ? calculate(result, operator, inputText)
            : inputText;
        operator = '+';
      } else if (name == '-') {
        result = result.isNotEmpty
            ? calculate(result, operator, inputText)
            : inputText;
        operator = '-';
      } else if (name == '×') {
        result = result.isNotEmpty
            ? calculate(result, operator, inputText)
            : inputText;
        operator = '×';
      } else if (name == '÷') {
        result = result.isNotEmpty
            ? calculate(result, operator, inputText)
            : inputText;
        operator = '÷';
      } else if (name == '=') {
        result = result.isNotEmpty
            ? calculate(result, operator, inputText)
            : inputText;
        operator = '=';
      }
      inputText = result;
      print('display ' + numberFormat(inputText));

      displayKey.currentState?.displayText = inputText;

      inputText = '';
    };

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
              child: Column(
                //縦に並べる
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Display(key: displayKey),
                  ),
                  Row(
                    //横に並べる
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createButton('AC', onClick: allClearClick),
                      createButton('x²', onClick: exponentiationClick),
                      createButton('+/-', onClick: plusminusClick),
                      createBackSpaceButton(displayKey),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createButton('7', isRound: true, onClick: numberClick),
                      createButton('8', isRound: true, onClick: numberClick),
                      createButton('9', isRound: true, onClick: numberClick),
                      createButton('+', onClick: operatorClick),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createButton('4', isRound: true, onClick: numberClick),
                      createButton('5', isRound: true, onClick: numberClick),
                      createButton('6', isRound: true, onClick: numberClick),
                      createButton('-', onClick: operatorClick),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createButton('1', isRound: true, onClick: numberClick),
                      createButton('2', isRound: true, onClick: numberClick),
                      createButton('3', isRound: true, onClick: numberClick),
                      createButton('×', onClick: operatorClick),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createButton('.', onClick: dotClick),
                      createButton('0', isRound: true, onClick: numberClick),
                      createButton('=', onClick: operatorClick),
                      createButton('÷', onClick: operatorClick),
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

//ボタンの生成
  Widget createButton(
    String name, {
    bool isRound = false,
    required OnClickFunction onClick,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RectButton(name, isRound, () {
        print('やっほー  $name');

        //画面変更するときはsetStateで囲う
        setState(() async {
          int streamId = await _pool.play(tap!);
          onClick(name);
        });
      }),
    );
  }

//削除ボタンの生成
  Widget createBackSpaceButton(GlobalObjectKey<DisplayState> displayKey) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Icon_Button(
          icon: const Icon(Icons.backspace),
          isRound: false,
          onTap: () {
            print('やっほー  backspace');

            //画面変更するときはsetStateで囲う
            setState(() {
              inputText = inputText.substring(0, inputText.length - 1);

              displayKey.currentState?.displayText = inputText;
            });
          }),
    );
  }
}

String getFloatString(String str) {
  String s = str.contains('.')
      ? (str.substring(str.indexOf('.') + 1, str.length))
      : '0';

  return s;
}

int purseNumberString(String str) {
  int n = str.contains('.')
      ? int.parse(str.substring(0, str.indexOf('.')))
      : int.parse(str);

  return n;
}

String zeroPadding(String str, int length) {
  while (str.length < length) {
    str += '0';
  }

  return str;
}

String calculate(String left, String op, String right) {
  print('op ' + op);
  print('left' + left);
  print('right' + right);

  String sl = getFloatString(left);
  String sr = getFloatString(right);

  //桁数合わせ
  if (sl.length > sr.length) {
    sr = zeroPadding(sr, sl.length);
  } else if (sl.length < sr.length) {
    sl = zeroPadding(sl, sr.length);
  }

  int il = purseNumberString(left);
  int ir = purseNumberString(right);

  //少数の桁
  int l = sl.length;
  int len = 1;
  for (int i = 0; i < l; i++) {
    len *= 10;
  }

  //floatLeft,floatRight
  int fl = int.parse(sl);
  int fr = int.parse(sr);

  print('fl ' + fl.toString());
  print('fr ' + fr.toString());

  //normalLeft,normalRight  かけざんとわりざんに使う
  double nl = double.parse(left.replaceAll('.', ''));
  double nr = double.parse(right.replaceAll(',', ''));

  int f = 0;
  int i = 0;
  double n = 0;
  String sn = '0';

  //足し算
  if (op == '+') {
    f = (fl + fr) % len;
    i = il + ir + (fl + fr) ~/ len;
  }
  //引き算
  if (op == '-') {
    if (il < ir) {
      int a = fl;
      fl = fr;
      fr = a;
    }
    if (fl < fr) {
      fl += 1 * len;
      il -= 1;
    }

    f = fl - fr;
    i = il - ir;
  }
  //掛け算
  if (op == '×') {
    n = nl * nr;
    n = left.contains('.') || right.contains('.') ? n / len : n;
    sn = n.toString();

    i = (sn.contains('.') ? int.parse(sn.substring(0, sn.indexOf('.'))) : n)
        as int;
    f = sn.contains('.')
        ? int.parse(sn.substring(sn.indexOf('.') + 1, sn.length))
        : 0;
  }
  //わり算
  if (op == '÷') {
    f = 0;
    i = (nl / nr) as int;
  }

  print(f == 0 ? i.toString() : i.toString() + '.' + f.toString());
  return (f == 0 ? i.toString() : i.toString() + '.' + f.toString()).toString();
}

String numberFormat(String num) {
  num = num.replaceAll('-', '');

  String right = '';
  if (num.contains('.')) {
    right = num.substring(num.indexOf('.'), num.length);
    num = num.substring(0, num.indexOf('.'));
  }

  String str = '';
  int len = (num.length - 1) ~/ 3;

  for (int i = 0; i < len; i++) {
    str = ',' + num.substring(num.length - 3, num.length) + str;
    num = num.substring(0, num.length - 3);
  }

  return num + str + right;
}
