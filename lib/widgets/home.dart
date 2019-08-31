import 'package:flutter/material.dart';
import 'package:flutter_quizz_skilleos/widgets/custom_text.dart';
import 'package:flutter_quizz_skilleos/widgets/page_quizz.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              elevation: 10.0,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset("quizz_assets/quizzLogo.jpg",
                fit: BoxFit.contain,),
              ),
            ),
            RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return PageQuizz();
                  }));
                },
                child: CustomText("Commencer le quizz", factor: 1.5,),
            ),
          ],
        ),
      ),
    );
  }
}
