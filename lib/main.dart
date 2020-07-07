import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

Questions questions = new Questions();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scores = [];

  void updateScore(bool userSelectedAnswer) {
    bool correctAns = questions.getAnswer();
    setState(() {
      if (questions.moreQuestionsAvailable()) {
        if (userSelectedAnswer == correctAns) {
          scores.add(Icon(
            Icons.check,
            size: 20,
            color: Colors.green,
          ));
        } else {
          scores.add(Icon(
            Icons.clear,
            size: 20,
            color: Colors.red,
          ));
        }
        questions.getNextQuestion();
      } else {
        Alert(context: context, title: "Finished", desc: "You have reached the end of the quiz!").show();
        questions.reset();
        scores.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                updateScore(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                updateScore(false);
              },
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: scores),
      ],
    );
  }
}
