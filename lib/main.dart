import 'package:flutter/material.dart';
import 'package:flutter_calculator_application/constants.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApplication());
}

class CalculatorApplication extends StatefulWidget {
  CalculatorApplication({Key? key}) : super(key: key);

  @override
  State<CalculatorApplication> createState() => _CalculatorApplicationState();
}

class _CalculatorApplicationState extends State<CalculatorApplication> {
  var inputUser = '';
  var result = '';
  void btnPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0.0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text1),
          ),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              btnPressed(text1);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26.0, color: getOperatorPrimaryColor(text1)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0.0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text2),
          ),
          onPressed: () {
            if (text2 == 'ce') {
              if (inputUser.length > 0) {
                setState(() {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                });
              }
            } else {
              btnPressed(text2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26.0, color: getOperatorPrimaryColor(text2)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0.0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text3),
          ),
          onPressed: () {
            btnPressed(text3);
          },
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26.0, color: getOperatorPrimaryColor(text3)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0.0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text4),
          ),
          onPressed: () {
            if (text4 == '=') {
              if (inputUser.length > 0) {
                Parser parser = Parser();
                Expression expression = parser.parse(inputUser);
                ContextModel contextModel = ContextModel();

                double eval =
                    expression.evaluate(EvaluationType.REAL, contextModel);
                setState(() {
                  result = eval.toString();
                  inputUser = result;
                });
              }
            } else {
              btnPressed(text4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26.0, color: getOperatorPrimaryColor(text4)),
            ),
          ),
        ),
      ],
    );
  }

  bool isOperator(String text) {
    var operators = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var operator in operators) {
      if (operator == text) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getOperatorPrimaryColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: textGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          result,
                          textAlign: TextAlign.end,
                          style: TextStyle(color: textGrey, fontSize: 60.0),
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 7,
              child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow('ac', 'ce', '%', '/'),
                      getRow('7', '8', '9', '*'),
                      getRow('4', '5', '6', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('00', '0', '.', '='),
                    ],
                  )),
            )
          ],
        )),
      ),
    );
  }
}
