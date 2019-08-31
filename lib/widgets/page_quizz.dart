import 'package:flutter/material.dart';
import 'package:flutter_quizz_skilleos/widgets/custom_text.dart';
import 'package:flutter_quizz_skilleos/widgets/question.dart';

class PageQuizz extends StatefulWidget {

  @override
  _PageQuizzState createState() => _PageQuizzState();
}

class _PageQuizzState extends State<PageQuizz> {

  Question question;

  List<Question> questionList = [
    Question("Beerus est-il le dieu de la destruction ?", true, "C'est en effet le dieu de la destruction, San Goku l'affronta lors d'un film OAV", "beerus.png"),
    Question("Broly peut-il battre Vegeta seul ?", true, "Il est de loin le sayan le plus fort de tous les temps", "broly.png"),
    Question("Bulma a rencontré San Goku durant les épisodes de Dragon Ball Z ?", false, "Et non c'était durant les épisodes de Dragon Ball", "bulma.jpg"),
    Question("Gogeta est-il la fusion de Trunks et San Goten", false, "Gotrunk = Trunks & San Goten, Gogeta = Vegeta & San Goku", "gogeta.png"),
    Question("San Gohan a atteint le sayan 2 en premier ?", true, "En effet lors de l'arc Cell", "gohan.png"),
    Question("Piccolo est un méchant ?", false, "Au début oui, mais San Goku l'a fait changer", "piccolo.jpg"),
    Question("San Goku est un surdoué du combat ?", true, "Certes sur le plan génétique il n'a aucune prédisposition, cependant il a une facilité extraordinaire en ce qui concerne l'évolution", "sangoku.png"),
    Question("Ce trunks vient-il du futur ?", true, "En effet il apparait lors de l'arc Cell", "trunks.jpg"),
    Question("Vegeta déteste San Goku ?", false, "Il déteste l'idée que San Goku soit plus fort que lui, mais il l'aime comme un frère d'arme en réalité", "vegeta.jpg"),
    Question("Whis est-il un ange ?", true, "C'est un ange, mais nous ne savons pas grand chose à son sujet", "whis.png"),
  ];

  int index = 0;
  int score = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    question = questionList[index];
  }


  @override
  Widget build(BuildContext context) {

    double size = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: CustomText('Le Quizz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomText("Question : ${index+1}", color: Colors.blueAccent, factor: 2.0, bold: FontWeight.bold,),
            CustomText("Score : $score / $index", color: Colors.blueAccent, factor: 1.5,),
            Card(
              elevation: 10.0,
              child: Container(
                height: size,
                width: size,
                child: Image.asset("quizz_assets/${question.imagePath}",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            CustomText(question.question, color: Colors.black, factor: 1.5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button(true),
                button(false)
              ],
            )
          ],
        ),
      ),
    );
  }

  RaisedButton button(bool b) {
    return RaisedButton(
        elevation: 5.0,
        onPressed: () => dialog(b),
        color: Colors.blueAccent,
        child: CustomText((b)? "Vrai" : "Faux", factor: 1.5,),
    );
  }

  Future<Null> dialog(bool b) async {
    bool rightAnswer = (b == question.answer);
    String isTrue = "win.png";
    String isFalse = "fail.png";
    if(rightAnswer) {
      score++;
    }
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: CustomText((rightAnswer)? "Gagné" : "Faux", color: Colors.white, bold: FontWeight.bold, factor: 2.0,),
            backgroundColor: (rightAnswer)? Colors.green : Colors.red,
//            contentPadding: EdgeInsets.all(20.0),
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Image.asset("quizz_assets/${(rightAnswer)? isTrue : isFalse}"),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: CustomText(question.explanation, color: Colors.black,),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  goToNextQuestion();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomText("Suivant", color: Colors.white, factor: 1.5,),
                  ],
                )
              ),
            ],
          );
        }
    );
  }

  Future<Null> finalDialog() async {
    return showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext finalContextDialog) {
      return AlertDialog(
        backgroundColor: Colors.blueAccent,
        title: CustomText("Fin de la partie", color: Colors.white, factor: 1.25,),
        contentPadding: EdgeInsets.all(10.0),
        content: CustomText("Score final : $score / $index", color: Colors.black, factor: 1.0,),
        actions: <Widget>[
          FlatButton(
              color: Colors.white,
              onPressed: () {
                backToStart(finalContextDialog, context);
              },
              child: CustomText("OK", color: Colors.blueAccent, factor: 1.25,)
          )
        ],
      );
      }
    );
  }

  void backToStart(BuildContext a, BuildContext b) {
    Navigator.pop(a);
    Navigator.pop(b);
  }

  void goToNextQuestion() {
    if(index < questionList.length - 1) {
      index++;
      setState(() {
        question = questionList[index];
      });
    } else {
      finalDialog();
    }
  }
}