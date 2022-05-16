import 'package:sample2/pegasusmodule/pages/Home/_hometab.dart';
import 'package:sample2/pegasusmodule/pages/Listening/totalnewslistening.dart';
import 'package:sample2/pegasusmodule/pages/Reading/totalnews.dart';
import 'package:sample2/pegasusmodule/pages/Vocabulary/_categoryvoca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const totalNewsReading(),
    const totalNews(),
    // ListCategoryVoca(),
    // FetchVoca(),
    const CategoryVoca(),
    const HomeTab()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CupertinoPageScaffold(
            child: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
        BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Nghe'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Đọc'),
        BottomNavigationBarItem(icon: Icon(Icons.read_more), label: 'Từ vựng'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance), label: 'Tài khoản'),
      ]),
      tabBuilder: (BuildContext context, int index) {
        return _tabs[index];
      },
    )));
    // Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Fetch Data Example'),
    //     ),
    //     body:

    // );
  }
}
