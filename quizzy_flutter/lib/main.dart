import 'package:flutter/material.dart';
import 'quizz_brain.dart';

QuizzBrain quizzBrain = QuizzBrain();

void main() => runApp(Quizzy());

class Quizzy extends StatelessWidget {
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
  List<Icon> scoreKeeper = [];

  Widget trueFlatButton() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          color: Colors.green,
          onPressed: () {
            //The user picked true.
            setState(() {
              if (quizzBrain.getQuestionAnswer() == true) {
                scoreKeeper.add(checkIcon());
              } else {
                scoreKeeper.add(crossIcon());
              }
              quizzBrain.nextQuestion();
            });
          },
          child: Text(
            'True',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget flaseFlatButton() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          color: Colors.red,
          onPressed: () {
            setState(() {
              if (quizzBrain.getQuestionAnswer() == false) {
                scoreKeeper.add(checkIcon());
              } else {
                scoreKeeper.add(crossIcon());
              }
              quizzBrain.nextQuestion();
            });
          },
          child: Text(
            'False',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget questionText() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            quizzBrain.getQuestionText(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget clearButton() {
    return Container(
        alignment: Alignment.topRight,
        child: ClipOval(
          child: Material(
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  scoreKeeper.clear();
                });
              },
              child: Icon(Icons.close),
            ),
          ),
        ));
  }

  Icon checkIcon() {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Icon crossIcon() {
    return Icon(
      Icons.close,
      color: Colors.red,
    );
  }

  Widget scoreIcons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: scoreKeeper,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          clearButton(),
          questionText(),
          trueFlatButton(),
          flaseFlatButton(),
          scoreIcons(),
        ],
      ),
    );
  }
}
