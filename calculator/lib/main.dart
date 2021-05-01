import 'package:flutter/material.dart';
import 'package:calculator/button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userQuestion = '';
  var userAnswer = '';
  var answerPass = '';
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);
  final List<String> buttons =
  [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title: Text('Calculator'),
        backgroundColor: Colors.deepPurple,
      ),
        backgroundColor: Colors.deepPurple[100],
        body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              color: Colors.deepPurple[200],
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.centerLeft,
                              child: Text(userQuestion, style: TextStyle(fontSize: 30))
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              color: Colors.deepPurple[200],
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.centerRight,
                              child: Text(userAnswer, style: TextStyle(fontSize: 30))
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      padding: const EdgeInsets.all(15.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                          itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return MyButton(
                            buttonTapped: (){
                              setState(() {
                                userQuestion = '';
                                userAnswer = '';
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.green,
                            textColor: Colors.white,
                          );
                        }
                        else if(index == 1) {
                          return MyButton(buttonTapped: (){
                                setState(() {
                                  if (userQuestion != '') {
                                    userQuestion = userQuestion.substring(0, userQuestion.length-1);
                                  }
                                });
                              },
                            buttonText: buttons[index],
                            color: Colors.red,
                            textColor: Colors.white
                          );
                        }
                        else if(index == buttons.length-2) {
                          return MyButton(buttonTapped: (){
                            setState(() {
                              if (userAnswer != '') {
                                userQuestion += buttons[index];
                                answerPass = userAnswer;
                              }
                            });
                          },
                              buttonText: buttons[index],
                              color: Colors.deepPurple[50],
                              textColor: Colors.deepPurple,
                          );
                        }
                        else if(index == buttons.length-1) {
                          return MyButton(buttonTapped: (){
                            setState(() {
                              equalPressed(answerPass);
                            });
                          },
                              buttonText: buttons[index],
                              color: Colors.deepPurple,
                              textColor: Colors.white
                          );
                        }
                        else {
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                            textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                          );
                        }
                      }
                  ),
                ),
              )
            ]
        )
    );
  }
  bool isOperator(String x) {
    if(x == '%' || x == '/' || x == 'x' || x == '+' || x == '-' || x == '=' ) {
      return true;
    }
    return false;
  }

  void showAlert() {
    AlertDialog(
      title: Text('Reset settings?'),
      content: Text('This will reset your device to its default factory settings.'),
    );
  }
  void equalPressed(answerPass) {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    finalQuestion = finalQuestion.replaceAll('ANS', answerPass);

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    if (eval % 1 == 0) {
      int result = eval.round();
      userAnswer = result.toString();
    }
    else {
      userAnswer = eval.toString();
    }

  }
}
