// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:sample2/pegasusmodule/pages/Vocabulary/_choosegame.dart';
// import 'package:sample2/pegasusmodule/pages/Vocabulary/games/Flashcard/FetchVocaFlashcard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const Color myColor = Colors.black;

class CategoryVoca extends StatefulWidget {
  const CategoryVoca({Key? key}) : super(key: key);

  @override
  _CategoryVocaState createState() => _CategoryVocaState();
}

class _CategoryVocaState extends State<CategoryVoca> {
  var api = "http://192.168.1.45:3000/categorys/search-category";
  var res, categorys;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    res = await http.get(Uri.parse(api));
    categorys = jsonDecode(res.body)["packList"];
    // print(categorys.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: res != null
          ? ListView.builder(
              itemCount: categorys.length,
              itemBuilder: (context, index) {
                var category = categorys[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    leading: Hero(
                      tag: category["key_search"],
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          category["categoryThumb"] ??
                              "http://www.4motiondarlington.org/wp-content/uploads/2013/06/No-image-found.jpg",
                        ),
                      ),
                    ),
                    title: Text(
                      "${category["category_en"]}",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "${category["category_vi"]}",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => FetchVocaFlashcard(category: category["key_search"],),
                          builder: (context) => const chooseGame(),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : const CircularProgressIndicator(backgroundColor: Colors.black),
    );
  }
}
