import 'package:flutter/material.dart';

import 'components/_listeningtab.dart';  
 
 final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.white,
  minimumSize: const Size(250, 100),
  padding: const EdgeInsets.symmetric(horizontal: 10),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

// ignore: camel_case_types
class totalNewsReading extends StatelessWidget {
  const totalNewsReading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder( 
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (_, i) {
          if (i == 0) {
            return 
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                const Divider(
                  height: 20,
                  thickness: 5,
                  // indent: 20,
                  // endIndent: 0,
                  color: Colors.grey,
                ),
                const Padding(padding: EdgeInsets.only(left: 5,bottom: 5),child: Text('Podcast',style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: "RobotoSlab",fontWeight:FontWeight.bold,decoration: TextDecoration.none),),) 
                ,_horizontalListView(context)
              ]
            ); 
          } else {
            return 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                const Divider(
                  height: 20,
                  thickness: 5,
                  // indent: 20,
                  // endIndent: 0,
                  color: Colors.grey,
                ),
                const Padding(padding: EdgeInsets.only(left: 5,bottom: 5),child: Text('Video',style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: "RobotoSlab",fontWeight:FontWeight.bold,decoration: TextDecoration.none),),) 
                ,_verticleListView(context)
              ]
            );
            
          }
        },
      ),
    );
  }
}

void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListeningTab(paragraph: '',)));
  }


Widget _verticleListView(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 400,
      child: ListView.builder( 
        itemCount: 15,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, __) => ElevatedButton(onPressed: () { 
          _navigateToNextScreen(context);
         },
        child:  _buildBoxVerticle(),
        style: raisedButtonStyle,
        ), 
      ),
    );
  }

 Widget _horizontalListView(BuildContext context) {
    return SizedBox(
      height: 170,
      width: 400,
      child: ListView.builder(  
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => ElevatedButton(onPressed: () {  
          _navigateToNextScreen(context);
        },
        child: _buildBoxHorizontal(),
        style: raisedButtonStyle,
        ) 
      ),
    );
  }

  Widget _buildBoxHorizontal() => Container( 
  // color: color,
  child: Column(
    children: [Container(width: 250,height: 150,decoration: BoxDecoration( 
      image: const DecorationImage(fit: BoxFit.cover,image: NetworkImage('https://znews-photo.zingcdn.me/w660/Uploaded/natmzz/2022_05_09/gettyimages_1396128767_594x594.jpg')),
          borderRadius: BorderRadius.circular(20),
    ), 
    ),
    const Text('Real thất bại ở derby Madrid',style: TextStyle(color: Colors.grey,fontSize: 15,fontFamily: "RobotoSlab",
                              fontWeight:FontWeight.normal,decoration: TextDecoration.none) ,)
    ]
  ),
  );


   Widget _buildBoxVerticle() => Container( 
    //  color: color,
  child: Column(
    children: [ 
      Container( 
      decoration: BoxDecoration(  
      borderRadius: BorderRadius.circular(20),
    ), 
    child: Padding(padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: Row(
      children: [
        Container(  
          width: 150,
          height: 120,
          decoration: BoxDecoration(  
          image: const DecorationImage(fit: BoxFit.cover,
          image: NetworkImage('https://znews-photo.zingcdn.me/w660/Uploaded/natmzz/2022_05_09/gettyimages_1396128767_594x594.jpg')),
          borderRadius: BorderRadius.circular(20),
        ),
        ),
        Container( 
          width: 220,
          child: Column(
            children: [
              Container(
              alignment: Alignment.topLeft,
              width: 220,
              height: 80,
              child: const Padding(padding: EdgeInsets.all(5),child:  Text('Real thất bại ở derby Madrid',style: TextStyle(color: Colors.grey,fontSize: 15,fontFamily: "RobotoSlab",
                                  fontWeight:FontWeight.normal,decoration: TextDecoration.none)),)  ,
                ),
              Container(
                alignment: Alignment.bottomRight,
                width: 220, 
                child: const Padding(padding: EdgeInsets.all(5),child:  Text('32:28',style: TextStyle(color: Colors.grey,fontSize: 15,fontFamily: "RobotoSlab",
                                    fontWeight:FontWeight.normal,decoration: TextDecoration.none)),)  ,
              )  
            ],
          ),
        ),  
      ],
    ),
    ) 
    ,
    ) 
    ]
  ),
  );