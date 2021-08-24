import 'package:calculator/pasrser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unicons/unicons.dart';

void main() {
  runApp(HomePage());
}

class KeyPad {
  String? label;
  bool? isOperator;
  bool? isEqualsBtn;
  bool? isClearBtn;
  bool? isBackspaceBtn;
  Icon? icon;

  KeyPad({
    this.label,
    this.isOperator,
    this.isEqualsBtn,
    this.isClearBtn,
    this.isBackspaceBtn,
    this.icon,
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

  bool endsWithOperator() {
    return inputValue.endsWith("+") ||
        inputValue.endsWith("-") ||
        inputValue.endsWith("*") ||
        inputValue.endsWith("x") ||
        inputValue.endsWith("/") ||
        inputValue.endsWith("%");
  }

  void handleInput(String label, {bool? isOperator}) {
    setState(() {
      if (isOperator == true && endsWithOperator())
        inputValue = inputValue.substring(0, inputValue.length - 1);
      else if (label == ".") {
        if (inputValue.isEmpty)
          inputValue = "0.";
        else if (inputValue.contains("."))
          return;
        else
          inputValue += label;
      } else
        inputValue += label;
    });
  }

  void backspace() {
    setState(() {
      if (inputValue.isNotEmpty)
        inputValue = inputValue.substring(0, inputValue.length - 1);
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
    KeyPad(
        icon: Icon(
          Icons.backspace,
          color: Colors.white,
        ),
        isBackspaceBtn: true),
    KeyPad(label: "/", isOperator: true),
    KeyPad(label: "CE", isClearBtn: true),
    KeyPad(label: "=", isEqualsBtn: true),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors().backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Icon(
              Icons.history,
              color: Colors.white,
            ),
            SizedBox(width: 20),
          ],
        ),
        drawer: Container(
          color: Colors.black.withOpacity(0.8),
          width: 300,
          child: ListView(
            children: [
              DrawerHeader(child: Container()),
              ListTile(
                leading: Icon(UniconsLine.sigma, color: Colors.white),
                title: Text(
                  "Scientific Calculator",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(UniconsLine.angle_right, color: Colors.white),
              ),
              ListTile(
                leading: Icon(UniconsLine.dollar_alt, color: Colors.white),
                title: Text(
                  "Currency Converter",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(UniconsLine.angle_right, color: Colors.white),
              ),
              ListTile(
                leading: Icon(UniconsLine.weight, color: Colors.white),
                title: Text(
                  "BMI Calculator",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(UniconsLine.angle_right, color: Colors.white),
              ),
              Stack(
                children: [
                  Container(
                    height: 200,
                    margin: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 100,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Upgrade to Premium",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "\n\nSolve algebra, quadratic equations, trignometry, calculus and many more... ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 40,
                      right: 0,
                      child: SvgPicture.asset(
                        "assets/icons/premium.svg",
                        width: 100,
                      ))
                ],
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 30,
                right: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      answer,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      inputValue,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
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
                                      : keypad.isBackspaceBtn == true
                                          ? backspace()
                                          : handleInput(keypad.label ?? "",
                                              isOperator: keypad.isOperator),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
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
        padding: keypad.isEqualsBtn == true
            ? EdgeInsets.symmetric(horizontal: 105, vertical: 20)
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
      child: keypad.icon != null
          ? keypad.icon!
          : Text(
              keypad.label ?? "",
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
