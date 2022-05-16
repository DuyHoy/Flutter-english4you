// import 'package:sample2/pegasusmodule/pages/Accounts/Login.dart';
// ignore_for_file: deprecated_member_use

import 'package:sample2/pegasusmodule/pages/Vocabulary/_listsearchwords.dart';
import 'package:sample2/pegasusmodule/pages/Vocabulary/games/Flashcard/_fetchvocaflashcard.dart';
import 'package:sample2/pegasusmodule/pages/Vocabulary/games/quizQuestion/screens/quiz/quiz_screen.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';

// ignore: camel_case_types
class chooseGame extends StatelessWidget {
  const chooseGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body:
            // SingleChildScrollView(
            //   physics: const ScrollPhysics(),
            //   child:
            Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                child: Row(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: ButtonTheme(
                            height: 100,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const FetchVocaFlashcard(
                                          category: 'accounting',
                                        )));
                              },
                              child: const Text(
                                "Flashcard",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )))),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: ButtonTheme(
                            height: 100,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const QuizScreen()));
                              },
                              child: const Text(
                                "Quiz question",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )))),
              ],
            )),
            const Expanded(
              child: ListSearch(
                category: "accounting",
              ),
              flex: 4,
            ),
          ],
        )
        // )
        );
  }
}
