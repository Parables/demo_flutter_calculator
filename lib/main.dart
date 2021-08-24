import 'package:calculator/pasrser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(HomePage());
}

class KeyPad {
  String label;
  bool? isOperator;
  bool? isEqualsBtn;

  KeyPad({
    required this.label,
    this.isOperator,
    this.isEqualsBtn,
  });
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String inputValue = "10+2";

  dynamic calcInput() {
    double res = double.parse(buildParser().parse(inputValue).value.toString());
    print(res);
    return res;
  }

  void handleInput(String label) {
    setState(() {
      inputValue += label;
    });
  }

  List<KeyPad> keysPadList = [
    KeyPad(label: "7"),
    KeyPad(label: "8"),
    KeyPad(label: "9"),
    KeyPad(label: "+", isOperator: true),
    KeyPad(label: "4"),
    KeyPad(label: "5"),
    KeyPad(label: "6"),
    KeyPad(label: "-", isOperator: true),
    KeyPad(label: "1"),
    KeyPad(label: "2"),
    KeyPad(label: "3"),
    KeyPad(label: "x", isOperator: true),
    KeyPad(label: "0"),
    KeyPad(label: "."),
    KeyPad(label: "=", isEqualsBtn: true),
    KeyPad(label: "/", isOperator: true),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors().backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    inputValue,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text("0"),
                  Text("0"),
                  Spacer(),
                  Expanded(
                    child: Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: keysPadList
                          .map((keypad) => KeypadWidget(
                                keypad: keypad,
                                onPressed: () => keypad.isEqualsBtn == true
                                    ? calcInput()
                                    : handleInput(keypad.label),
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        /*    bottomSheet: BottomSheet(
          onClosing: () {},
          builder: (context) => Container(
            height: 300,
            color: Colors.white,
          ),
        ), */
      ),
    );
  }
}

class KeypadWidget extends StatelessWidget {
  final KeyPad keypad;
  final Function()? onPressed;

  KeypadWidget({required this.keypad, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(20),
        backgroundColor: keypad.isEqualsBtn == true
            ? Colors.cyan
            : keypad.isOperator == true
                ? Colors.blue
                : AppColors().keyColor,
        shape: keypad.isOperator == true
            ? CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
      ),
      onPressed: onPressed,
      child: Text(
        keypad.label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class AppColors {
  final Color backgroundColor = Color.fromRGBO(30, 38, 53, 1);
  final Color keyColor = Color.fromRGBO(40, 53, 75, 1);
}
