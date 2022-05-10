import 'package:flutter/material.dart';
import 'package:flutter_application_2/Create_button.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // initialize variables
  String equation = "";
  String Answer = "";
  String ANS = "";
  List<String> ButtonsText = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Display Equation & Answer
          Expanded(
              child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Text(
                  equation,
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: Text(
                  Answer,
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),

          // Display Buttons
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.orangeAccent.withOpacity(0.5),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: ButtonsText.length,
                itemBuilder: (context, index) {
                  // Clear Button (C)
                  if (index == 0) {
                    return CreateButton(
                        action: () {
                          setState(() {
                            if (Answer.isNotEmpty) {
                              ANS = Answer;
                            }
                            equation = '';
                            Answer = '';
                          });
                        },
                        color: Colors.red,
                        colorText: Colors.white,
                        text: ButtonsText[index]);
                  }
                  // Delete Button (DEL)
                  else if (index == 1) {
                    return CreateButton(
                        action: () {
                          setState(() {
                            if (equation.length > 0) {
                              equation =
                                  equation.substring(0, equation.length - 2);
                            }
                          });
                        },
                        color: Colors.red,
                        colorText: Colors.white,
                        text: ButtonsText[index]);
                  }
                  // Equal Button
                  else if (index == ButtonsText.length - 1) {
                    return CreateButton(
                        action: () {
                          setState(() {
                            Equal();
                          });
                        },
                        color: Colors.green,
                        colorText: Colors.white,
                        text: ButtonsText[index]);
                  }
                  // ANS Button
                  else if (index == ButtonsText.length - 2) {
                    return CreateButton(
                        action: () {
                          setState(() {
                            equation = ANS;
                          });
                        },
                        color: Colors.deepOrangeAccent,
                        colorText: Colors.white,
                        text: ButtonsText[index]);
                  }
                  // Rest of the buttons
                  else {
                    return CreateButton(
                      action: () {
                        setState(() {
                          equation += ButtonsText[index];
                          equation += " ";
                        });
                      },
                      color: check(ButtonsText[index])
                          ? Colors.deepOrange
                          : Colors.deepOrange[50],
                      colorText: check(ButtonsText[index])
                          ? Colors.white
                          : Colors.deepOrange,
                      text: ButtonsText[index],
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  bool check(String s) {
    if (s == '%' || s == '/' || s == 'x' || s == '-' || s == '+' || s == '=') {
      return true;
    }
    return false;
  }

  void Equal() {
    String finalequation = equation;
    finalequation = finalequation.replaceAll('x', '*');
    try {
      Parser p = Parser();
      Expression exp = p.parse(finalequation);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      Answer = eval.toString();
    } catch (e) {
      Answer = "Not valid equation";
    }
  }
}
