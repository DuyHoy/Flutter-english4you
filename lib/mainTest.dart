import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample2/authmodule/models/brew.dart';
import 'package:sample2/firestorecrawl/BrewPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FireStoreApp());
}

class FireStoreApp extends StatefulWidget {
  const FireStoreApp({Key? key}) : super(key: key);

  @override
  State<FireStoreApp> createState() => _FireStoreAppState();
}

class _FireStoreAppState extends State<FireStoreApp> {
  Stream<List<Brew>> readBrews() => FirebaseFirestore.instance
      .collection("brews")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Brew.fromJson(doc.data())).toList());

  Future<Brew?> readBrew(String uid) async {
    //get single document by ID
    final docUser = FirebaseFirestore.instance.collection("brews").doc(uid);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return Brew.fromJson(snapshot.data()!);
    }
  }

  Future createBrew({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection("brews").doc();
    final brew = Brew(id: docUser.id, name: name, strength: 1, sugars: "1");
    final json = brew.toJson();

    // create document and write data to firebase
    await docUser.set(json);
  }

  Widget buildBrews(Brew brew) => ListTile(
        leading: CircleAvatar(child: Text('${brew.name}')),
        title: Text(brew.strength.toString()),
        subtitle: Text(brew.sugars),
      );

  Future insertBrew() async {
    Brew brew = Brew(
      name: 'test1',
      strength: 21,
      sugars: '11',
    );
    // createBrew(brew);
    final docBrew = FirebaseFirestore.instance.collection('brews1').doc();
    brew.id = 'ok-chua';
    final json = brew.toJson();
    await docBrew.set(json);
    // Navigator.pop(context);
    print('ok chua');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(),
        ),
        // body: Center(
        //     child: StreamBuilder<List<Brew>>(
        //   stream: readBrews(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       final brews = snapshot.data!;
        //       return ListView(
        //         children: brews.map(buildBrews).toList(),
        //       );
        //     } else {
        //       return Text('sss');
        //     }
        //   },
        // )),
        body: Center(
            child: FutureBuilder<Brew?>(
          future: readBrew('iTuEuCaF25hgJGvNnSynqkFlh6z2'),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.hasData) {
              final brew = snapshot.data;
              return brew == null
                  ? Center(child: Text('no user'))
                  : buildBrews(brew);
            } else {
              return Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            insertBrew();
            print('data oke');
          },
        ),
        // body: BrewPage(),
      ),
    );
  }
}
