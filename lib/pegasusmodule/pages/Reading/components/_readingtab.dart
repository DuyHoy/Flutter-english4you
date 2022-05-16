import 'dart:convert';
import 'package:sample2/pegasusmodule/pages/Reading/components/_modelbottomsheet.dart';
import 'package:sample2/pegasusmodule/pages/Reading/provider/translator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
import '../models/news.dart';

Future<List<News>> fetchNews() async {
  List<News> _NewsList = <News>[];
  final response =
      await http.get(Uri.parse('http://192.168.1.45:3000/news/search-news'));

  if (response.statusCode == 200) {
    Map<String, dynamic> values;
    values = jsonDecode(response.body);
    if (values.isNotEmpty) {
      for (int i = 0; i < values['packList'].length; i++) {
        if (values['packList'][i] != null) {
          Map<String, dynamic> map = values['packList'][i];
          _NewsList.add(News.fromJson(map));
        }
      }
    }
    return _NewsList;
  } else {
    throw Exception('Failed to load vocabulary');
  }
}

class ReadingTab extends StatefulWidget {
  final String paragraph;

  const ReadingTab({Key? key, required this.paragraph}) : super(key: key);

  @override
  State<ReadingTab> createState() {
    // ignore: no_logic_in_create_state
    return _ReadingTabState(paragraph);
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.grey[300],
  minimumSize: const Size(40, 40),
  padding: const EdgeInsets.symmetric(horizontal: 10),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

final ButtonStyle raisedButton_choose_lang = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.transparent,
  padding: const EdgeInsets.symmetric(horizontal: 10),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

class _ReadingTabState extends State<ReadingTab> {
  late Future<List<News>> futureNews;
  late String para;
  final translator = GoogleTranslator();

  String paragraph;
  _ReadingTabState(this.paragraph);

  @override
  void initState() {
    super.initState();
    // futureNews=fetchNews();
    para = paragraph;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => TranslatorData(),
        child: MaterialApp(
            title: 'Google Translate',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color(0xff5848D9),
              scaffoldBackgroundColor: const Color(0xfff9f9f9),
            ),
            home: Scaffold(
              appBar: AppBar(
                  leading: GestureDetector(
                child: const Icon(Icons.arrow_back_rounded),
                onTap: () {
                  Navigator.pop(context);
                },
              )),
              body: FutureBuilder<List<News>>(
                future: fetchNews(), // async work
                builder:
                    (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
                  final translator = GoogleTranslator();
                  String fromLanguage =
                      Provider.of<TranslatorData>(context).fromLanguageValue;
                  String toLanguage =
                      Provider.of<TranslatorData>(context).toLanguageValue;
                  var provider = Provider.of<TranslatorData>(context);
                  var text;
                  final data = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Text('Loading....');
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        //newsParagrap( paragraph: data!);
                        return SafeArea(
                            child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Column(
                            children: [
                              Text(
                                data![0].newsTitle,
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontFamily: "RobotoSlab",
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none),
                              ),
                              ElevatedButton(
                                style: raisedButtonStyle,
                                onPressed: () async {
                                  text = await translator.translate(
                                      Text(data[0].newsTitle).data.toString(),
                                      from: fromLanguage,
                                      to: toLanguage);
                                  Provider.of<TranslatorData>(context,
                                          listen: false)
                                      .updateText(text: text.text);
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const modelbottomsheet();
                                      },
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                        ),
                                      ));
                                },
                                child: const Icon(Icons.g_translate),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  child: Image.network(data[0].newsImage,
                                      fit: BoxFit.fill),
                                ),
                              ),
                              ListView.builder(
                                  primary: false,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: data[0].newsContent.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(children: [
                                      Text(
                                        data[0].newsContent[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontFamily: "RobotoSlab",
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none),
                                      ),
                                      ElevatedButton(
                                        style: raisedButtonStyle,
                                        onPressed: () async {
                                          text = await translator.translate(
                                              Text(data[0]
                                                      .newsContent[index]
                                                      .toString())
                                                  .data
                                                  .toString(),
                                              from: fromLanguage,
                                              to: toLanguage);
                                          Provider.of<TranslatorData>(context,
                                                  listen: false)
                                              .updateText(text: text.text);
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const modelbottomsheet();
                                              });
                                        },
                                        child: const Icon(Icons.g_translate,
                                            size: 20),
                                      )
                                    ]);
                                  })
                            ],
                          ),
                        ));
                      }
                  }
                },
              ),
            )));
  }
}
