import 'package:provider/provider.dart';
import 'package:sample2/Screens/Dict/dict.dart';
import 'package:sample2/Screens/Welcome/welcome_screen.dart';
import 'package:sample2/authmodule/models/myuser.dart';
import 'package:flutter/material.dart';
import 'package:sample2/authmodule/screens/home/MenuPage.dart';
import 'package:sample2/ebookmodule/EBookPage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either the Home or Authenticate widget
    final user = Provider.of<MyUser?>(context);
    String? result = user?.uid;
    debugPrint('uid: $result');
    // return Text(result.toString());

    if (user?.uid == null) {
      // return const Authenticate();
      return WelcomeScreen();
    } else {
      return EBookPage();
      // return const MenuPage();
    }
  }
}
