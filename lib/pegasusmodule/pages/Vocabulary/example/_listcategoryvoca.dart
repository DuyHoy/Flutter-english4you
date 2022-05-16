// import 'package:sample2/pegasusmodule/pages/Accounts/Login.dart';
import 'package:sample2/pegasusmodule/pages/Vocabulary/games/Flashcard/_fetchvocaflashcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListCategoryVoca extends StatelessWidget {
  const ListCategoryVoca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CupertinoButton.filled(
            child: const Text('Báo cáo tài chính'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FetchVocaFlashcard(
                        category: 'accounting',
                      )));
            }),
        const SizedBox(
          height: 30,
        ),
        CupertinoButton.filled(
            child: const Text('Bảo hành'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FetchVocaFlashcard(
                        category: 'banking',
                      )));
            }),
        const SizedBox(
          height: 30,
        ),
        CupertinoButton.filled(
            child: const Text('Bất động sản'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FetchVocaFlashcard(
                        category: 'banking',
                      )));
            })
      ],
    ));
  }
}
