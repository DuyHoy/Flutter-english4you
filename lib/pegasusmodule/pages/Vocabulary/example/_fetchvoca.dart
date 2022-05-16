import 'dart:convert';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
List<Vocabulary> _vocaList =<Vocabulary>[]; 

Future<List<Vocabulary>> fetchVocabulary() async{
  final response=await http.get(Uri.parse('http://192.168.1.45:3000/words/search-word'));

  if(response.statusCode==200){   
     Map<String,dynamic> values;
    values=jsonDecode(response.body);
    if(values.isNotEmpty){  
      for(int i=0;i<values['packList'].length;i++){
        if(values['packList'][i]!=null){
          Map<String,dynamic> map=values['packList'][i];
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

  const Vocabulary({
    required this.words,
    required this.mean
  });

  factory Vocabulary.fromJson(Map<String,dynamic> json){ 
    return Vocabulary(words: json['word'], mean: json['mean']);
  }
}

class FetchVoca extends StatefulWidget{
  const FetchVoca({Key? key}):super(key: key);

  @override
  _FetchVoca createState() => _FetchVoca();
}

class _FetchVoca extends State<FetchVoca>{
  late Future<List<Vocabulary>> futureVoca;

  @override
  void initState(){
    super.initState();
     futureVoca=fetchVocabulary();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: FutureBuilder<List<Vocabulary>>(
            future: futureVoca , 
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final voca=snapshot.data;
                // return Text(snapshot.data!.length.toString());
               return buildVocas(voca!);
              //  Container(
              //   child: ListView.separated(   
              //       padding: const EdgeInsets.all(8),                                               
              //       itemCount: snapshot.data!.length,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (BuildContext context, int index) {
              //           return Text('${snapshot.data![index].words}');                                           
              //       }, separatorBuilder: (BuildContext context, int index) =>  const Divider() ,
              //   )
              //   );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        );
  }
}

Widget buildVocas(List<Vocabulary> vocabulary) => ListView.builder(
  itemCount: vocabulary.length,
  itemBuilder: (context,index){ 
    return ListTile( 
      title: Text(vocabulary[index].words),
      subtitle: Text(vocabulary[index].mean)
    );
  }
);