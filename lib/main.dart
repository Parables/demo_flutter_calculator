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
  bool? isClearBtn;

  KeyPad({
    required this.label,
    this.isOperator,
    this.isEqualsBtn,
    this.isClearBtn,
  });
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String inputValue = "";
  String answer = "";

  String calcInput() {
    print("inputValue: $inputValue");
    final result = buildParser().parse(inputValue);
    if (result.isSuccess) {
      print(result.value);
      setState(() {
        answer = result.value.toString();
      });
      return result.value.toString();
    } else {
      setState(() {
        answer = "Syntax Error";
      });
    }
    print("Syntax Error $result");
    return "Syntax Error";
  }

  void handleInput(String label) {
    setState(() {
      inputValue += label;
    });
  }

  void clearScreen() {
    setState(() {
      inputValue = "";
      answer = "";
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
    KeyPad(label: "CLEAR", isClearBtn: true),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors().backgroundColor,
        body: Center(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 20),
                Text(
                  answer,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text("0"),
                Text(
                  inputValue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: keysPadList
                        .map((keypad) => KeypadWidget(
                              keypad: keypad,
                              onPressed: () => keypad.isEqualsBtn == true
                                  ? calcInput()
                                  : keypad.isClearBtn == true
                                      ? clearScreen()
                                      : handleInput(keypad.label),
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(height: 40),
              ],
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
        padding: keypad.isClearBtn == true
            ? EdgeInsets.symmetric(horizontal: 60, vertical: 20)
            : EdgeInsets.all(20),
        backgroundColor: keypad.isEqualsBtn == true
            ? Colors.cyan
            : keypad.isClearBtn == true
                ? Colors.amber
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
