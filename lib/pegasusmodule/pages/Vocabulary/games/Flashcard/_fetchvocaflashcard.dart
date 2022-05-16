import 'dart:convert';
// import 'dart:js';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flash_card/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 


// ignore: non_constant_identifier_names
Future<List<Vocabulary>> FetchVocabularyFlashcard(String category) async{
  // final response=await http.get(Uri.parse('http://192.168.1.45:3000/words/search-word'));
  final response=await http.get(Uri.parse('http://192.168.1.45:3000/words/search-word-by-category?word='+category));
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

class FetchVocaFlashcard extends StatefulWidget{
  final String category;
  const FetchVocaFlashcard({Key? key, required this.category}):super(key: key);

 
  @override
  State<StatefulWidget> createState(){
    // ignore: no_logic_in_create_state
    return _FetchVocaFlashcard(category);
  } 
}

class _FetchVocaFlashcard extends State<FetchVocaFlashcard>{
  late Future<List<Vocabulary>> futureVoca;
  String category;
  _FetchVocaFlashcard(this.category);

  @override
  void initState(){
    super.initState(); 
     futureVoca=FetchVocabularyFlashcard(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: 
        Center(
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
        ),
      );
  }
}

Widget buildVocas(List<Vocabulary> vocabulary) => ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: vocabulary.length,
  itemBuilder: (context,index){
    return flash(vocabulary,index); 
  }
);

Widget flash(List<Vocabulary> vocabulary,int idx) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FlashCard(
  frontWidget: SizedBox(
      height: 500,
      width: 500, 
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
                  fontSize: 30),), 
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
          // Container( 
          //   child: Center(
          //       child: SizedBox.fromSize( 
          //     size: Size(56, 56), // button width and height
          //     child: ClipOval(
          //       child: Material(
          //         color: Colors.white,
          //         child: InkWell(
          //           splashColor: Colors.blue, // splash color
          //           onTap: () {
          //             readAudio('${vocabulary[idx].audio}'); 
          //           }, 
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget>[
          //               Icon(Icons.volume_down_sharp), 
          //             ], 
          //           ),
          //         ),
          //       ),
          //     ),
          //   )
          //   ),
          // ),
          const SizedBox(height: 10),
          SizedBox(
            //height: 300,
            width: 380,
            child: Image.network('https://tienganhmoingay.com/static/Vocabulary/images/word_images/abide_by.jpg',fit: BoxFit.fill)
          ),
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
      )),
  backWidget: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Center(
        child: Text(
          '',
          style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 15,
              fontWeight: FontWeight.w900),
        ),
      ),Center(
        child: Text(
          vocabulary[idx].words,
          style: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 20,
              fontWeight: FontWeight.w900),
        ),
      ),Center(
        child: Text(
          vocabulary[idx].mean,
          style: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 20,
              fontWeight: FontWeight.w900),
        ),
      )
    ],
  ), 
  height: 550,
  width: 400,
  )
    ],
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