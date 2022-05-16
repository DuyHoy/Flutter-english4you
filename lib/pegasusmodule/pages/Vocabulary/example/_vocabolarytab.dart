import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flash_card/flash_card.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class VocabolaryTab extends StatelessWidget{

  var dic = <Map<String, dynamic>>{
    {
      'words':'desire',
      'en': 'a strong wish to have or do songthing',
      'vi': 'thèm muốn, khát khao, ao ước',
      'phien_am': '/dɪˈzaɪə(r)/ ',
      'audio_us': 'assets/audio/love__us_1.mp3',
      'audio_uk': 'assets/audio/love__us_1.mp3',
      'vd_en':'We desire to have our own home',
      'vd_vi':'Chúng tôi ao ước có một ngôi nhà riêng',
      'img':'http://api.vocabinnews.com:9090/share/word/desire.jpg'
    } ,
    {
      'words':'desire',
      'en': 'a strong wish to have or do songthing',
      'vi': 'thèm muốn, khát khao, ao ước',
      'phien_am': '/dɪˈzaɪə(r)/ ',
      'audio_us': 'assets/audio/love__us_1.mp3',
      'audio_uk': 'assets/audio/love__us_1.mp3',
      'vd_en':'We desire to have our own home',
      'vd_vi':'Chúng tôi ao ước có một ngôi nhà riêng',
      'img':'http://api.vocabinnews.com:9090/share/word/desire.jpg'
    }
  };

  VocabolaryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Game Flashcard'),
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                    height: 500,
                    // width: 450,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: dic.map((dic) {
                        // return flash(dic['words'],dic['vi'], dic['en'],dic['vi'], dic['phien_am'],
                        //     dic['audio_us'],dic['img'],dic['vd_en'],dic['vd_vi']);
                        return flash(dic);
                      }).toList(),
                    ))
              ],
            )));
    // body: ListView.builder(
    //     itemCount: flashCard.length,
    //     itemBuilder: (context, index) {
    //       return flashcardList;
    //     }));

  }
}


// Widget flash(String words,String front, String back_en,
//               String back_vi, String phien_am, String audio,
//               String img,String vd_en,String vd_vi) {
  Widget flash(Map<String, dynamic> dic) {
  return FlashCard(
    frontWidget: SizedBox(
        height: 500,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [ 
            Text.rich( 
              TextSpan(
                text: '${dic['words']}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                 )),
            Text.rich(
                  TextSpan(
                    text: '/${dic['phien_am']}/',
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ),
            Center(
                child: SizedBox.fromSize( 
              size: const Size(56, 56), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    splashColor: Colors.blue, // splash color
                    onTap: () {
                      readAudio('${dic['audio_us']}'); 
                    }, 
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.volume_down_sharp), 
                      ], 
                    ),
                  ),
                ),
              ),
            )
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Image.network('${dic['img']}'),
            ),
            SizedBox(
              height: 25,
              child:Text('${dic['vd_en']}')
            ),
            SizedBox(
              height: 25,
              child:Text('${dic['vd_vi']}')
            )
          ],
        )),
    backWidget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            '${dic['en']}',
            style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 15,
                fontWeight: FontWeight.w900),
          ),
        ),Center(
          child: Text(
            '${dic['vi']}',
            style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 15,
                fontWeight: FontWeight.w900),
          ),
        )
      ],
    ),
    height: 450,
    width: 350,
  );
}



readAudio(String pathAudio) {
  final assetsAudioPlayer = AssetsAudioPlayer();
  try {
    assetsAudioPlayer.open(Audio(pathAudio));
  } catch (t) {
    // print(t.toString());
  }
}

void playAudioNetwork(String url) async{ 
      AudioPlayer audioPlayer = AudioPlayer();
    int result = await audioPlayer.play(url);
    if (result == 1) {
      // success
    } 
  }