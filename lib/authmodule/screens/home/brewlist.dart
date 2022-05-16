import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample2/authmodule/models/brew.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    // print(brews!.docs);

    // if (brews != null) {
    //   for (var doc in brews.docs) {
    //     print(doc.data());
    //   }
    // }

    brews.forEach((brew) {
      print(brew.name);
      print(brew.sugars);
      print(brew.strength);
    });

    return Container();
  }
}
