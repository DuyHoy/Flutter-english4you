import 'dart:convert';
import 'package:sample2/pegasusmodule/pages/Listening/provider/translator_provider.dart';
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

class ListeningTab extends StatefulWidget {
  final String paragraph;

  const ListeningTab({Key? key, required this.paragraph}) : super(key: key);

  @override
  State<ListeningTab> createState() {
    // ignore: no_logic_in_create_state
    return _ListeningTabState(paragraph);
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

class _ListeningTabState extends State<ListeningTab> {
  late Future<List<News>> futureNews;
  late String para;
  final translator = GoogleTranslator();

  String paragraph;
  _ListeningTabState(this.paragraph);

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
                final data = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('Loading....');
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      //newsParagrap( paragraph: data!);
                      return Scaffold(
                        body: SafeArea(
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
                              newsparagraph_translate(
                                  data[0].newsTitle, context),
                              ElevatedButton(
                                style: raisedButtonStyle,
                                onPressed: () async {},
                                child: const Icon(Icons.volume_up),
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
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      newsparagraph_translate(
                                          data[0].newsContent[index].toString(),
                                          context),
                                      ElevatedButton(
                                        style: raisedButtonStyle,
                                        onPressed: () async {},
                                        child: const Icon(Icons.volume_up,
                                            size: 20),
                                      )
                                    ]);
                                  })
                            ],
                          ),
                        )),
                      );
                    }
                }
              },
            ),
          )),
    );
  }
}

Widget newsparagraph_translate(String paragraph, BuildContext context) {
  // final translator = GoogleTranslator();
  //   String fromLanguage = Provider.of<TranslatorData>(context).fromLanguageValue;
  //   String toLanguage = Provider.of<TranslatorData>(context).toLanguageValue;
  //   var provider = Provider.of<TranslatorData>(context);
  //   var text = translator.translate(paragraph, from: fromLanguage, to: toLanguage);
  // Provider.of<TranslatorData>(context, listen: false).updateText(text: text.text);
  return SingleChildScrollView(
      child: Text(paragraph,
          style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: "RobotoSlab",
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none)));
}
