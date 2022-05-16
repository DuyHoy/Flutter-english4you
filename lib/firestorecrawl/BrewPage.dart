import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample2/authmodule/models/brew.dart';
import 'package:sample2/authmodule/services/database.dart';

class BrewPage extends StatefulWidget {
  const BrewPage({Key? key}) : super(key: key);

  @override
  State<BrewPage> createState() => _BrewPageState();
}

class _BrewPageState extends State<BrewPage> {
  final controllerName = TextEditingController();
  final controllerStrength = TextEditingController();
  final controllerSugars = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Brew'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: decoration('Name'),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerStrength,
            decoration: decoration('Streng'),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerSugars,
            decoration: decoration('Sugars'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () async {
                Brew brew = Brew(
                  name: controllerName.text,
                  strength: int.parse(controllerStrength.text),
                  sugars: controllerSugars.text,
                );
                // createBrew(brew);
                final docBrew =
                    FirebaseFirestore.instance.collection('brews').doc();
                brew.id = 'ok-chua';
                final json = brew.toJson();
                await docBrew.set(json);
                // Navigator.pop(context);
                print('ok chua');
              },
              child: const Text('Create')),
        ],
      ),
    );
  }

  Future createBrew(Brew brew) async {
    final docBrew = FirebaseFirestore.instance.collection('brews').doc();
    brew.id = 'ok-chua';
    final json = brew.toJson();
    await docBrew.set(json);
  }

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      );
}
