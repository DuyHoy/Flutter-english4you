// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flash_card/flash_card.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Vocabulary{
  final String words;
  final String mean;
  final String type;
  final String phonetic;
  final String note;
  final List<dynamic> examples; 
  final String audio;

  const Vocabulary({
    required this.words,
    required this.mean,
    required this.type,
    required this.phonetic,
    required this.note,
    required this.examples,
    required this.audio
  });

  factory Vocabulary.fromJson(Map<String,dynamic> json){ 
    return Vocabulary(words: json['word'], mean: json['mean'],
                      type: json['type'],phonetic: json['phonetic'],
                      note: json['note'],examples: json['examples'],
                      audio:json['audio']);
  }
}

const List<String> mainDataList = [
   "Apple",
   "Apricot",
   "Banana",
   "Blackberry",
   "Coconut",
   "Date",
   "Fig",
   "Gooseberry",
   "Grapes",
   "Lemon",
   "Litchi",
   "Mango",
   "Orange",
   "Papaya",
   "Peach",
   "Pineapple",
   "Pomegranate",
   "Starfruit"
  ];

List<String> newDataList = List.from(mainDataList);

TextEditingController _textController = TextEditingController();

// ignore: non_constant_identifier_names
Future<List<Vocabulary>> FetchVocabulary(String category) async{
  // final response=await http.get(Uri.parse('http://192.168.1.45:3000/words/search-word'));
  final response=await http.get(Uri.parse('http://192.168.1.45:3000/words/search-word-by-category?word=accounting'));//+category
List<Vocabulary> _vocaList =<Vocabulary>[]; 
  if(response.statusCode==200){   
     Map<String,dynamic> values;
    values=jsonDecode(response.body);
    if(values.isNotEmpty){  
      for(int i=0;i<values['packList'].length;i++){
        if(values['packList'].length>0){//['packList']
          Map<String,dynamic> map=values['packList'][i];//
            _vocaList.add(Vocabulary.fromJson(map)); 
        }
      }  
    } 
    return _vocaList;
  }else{
    throw Exception('Failed to load vocabulary');
  }
}

class ListSearch extends StatefulWidget { 
  final String category;
  const ListSearch({Key? key, required this.category}):super(key: key);
  
  @override
  State<ListSearch> createState(){
    // ignore: no_logic_in_create_state
    return _ListSearch(category);
  } 
 
} 
class _ListSearch extends State<ListSearch> {
late Future<List<Vocabulary>> futureVoca;
  String category; 
  _ListSearch(this.category); 
  List<Vocabulary> listvoca=[];

@override
  void initState(){
    super.initState(); 
     futureVoca=FetchVocabulary(category);
  }

onItemChanged(String value) {
    setState(() {  
      listvoca = listvoca
          .where((string) => string.words.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: <Widget>[
        SizedBox(
            height: 50,
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5), 
            child: TextField(
            controller: _textController,
            decoration: const InputDecoration( 
              contentPadding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
              hintText: 'Search Here...',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)))
            ),
            onChanged: onItemChanged, 
          ), 
        ),
        ),
        Expanded(
          child: FutureBuilder<List<Vocabulary>>(
          future: futureVoca , 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final voca=snapshot.data; 
             return buildVocas(voca!); 
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } 
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
        )
      ],
      ) 
    );
  }
}

Widget buildVocas(List<Vocabulary> vocabulary) => ListView.builder(
  // shrinkWrap: true,
  // physics: const NeverScrollableScrollPhysics(),
  itemCount: vocabulary.length,
  itemBuilder: (context,index){
    return flash(vocabulary,index); 
  }
);

Widget flash(List<Vocabulary> vocabulary,int idx) {
  return  Card(
                  child: Padding(padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [  
                      const SizedBox(height: 10),
                      RichText( 
                        text: 
                            TextSpan(text: vocabulary[idx].words, style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),), 
                      ), 
                      const SizedBox(height: 10), 
                          RichText(
                        text: TextSpan(text: 'US',style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                              children: [
                                const WidgetSpan(child: SizedBox(width: 5),),
                                const WidgetSpan(child: Icon(Icons.volume_down_sharp,color: Colors.blueGrey,size: 25,)),
                                const WidgetSpan(child: SizedBox(width: 5),),
                                TextSpan(text: vocabulary[idx].phonetic, style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),)
                              ]),  
                      ),
                      RichText(
                        text: TextSpan(text: 'UK',style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                              children: [
                                const WidgetSpan(child: SizedBox(width: 5),),
                                const WidgetSpan(child: Icon(Icons.volume_down_sharp,color: Colors.blueGrey,size: 25,)),
                                const WidgetSpan(child: SizedBox(width: 5),),
                                TextSpan(text: vocabulary[idx].phonetic, style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),)
                              ]),  
                      ), 
                      const SizedBox(height: 10), 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                          'Ví dụ:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        )
                        ], 
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                          '${vocabulary[idx].examples[0]}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        )
                        ], 
                      ),const SizedBox(height: 10,)
                      ,Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                          '${vocabulary[idx].examples[1]}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        )
                        ], 
                      )
                    ],
                  ))   
                  );
} 

readAudio(String pathAudio) {
  final assetsAudioPlayer = AssetsAudioPlayer();
  try {
    assetsAudioPlayer.open(  
      Audio.network(pathAudio),
      );
  } catch (t) {
    // print(t.toString());
  }
}