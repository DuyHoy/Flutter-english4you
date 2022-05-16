import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample2/authmodule/models/brew.dart';
import 'package:sample2/authmodule/screens/authenticate/sign_in.dart';
import 'package:sample2/authmodule/services/auth.dart';
import 'package:sample2/authmodule/services/database.dart';
import 'package:provider/provider.dart';
import 'package:sample2/authmodule/screens/home/brewlist.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    Brew n = Brew(id: '');
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').brews,
      initialData: [n],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('logout'),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
