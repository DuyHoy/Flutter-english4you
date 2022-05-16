import 'package:flutter/material.dart';
import 'package:sample2/authmodule/screens/home/wrapper.dart';
import 'package:sample2/authmodule/models/myuser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sample2/authmodule/services/auth.dart';
import 'package:sample2/ebookmodule/view_models/app_provider.dart';
import 'package:sample2/ebookmodule/view_models/details_provider.dart';
import 'package:sample2/ebookmodule/view_models/favorites_provider.dart';
import 'package:sample2/ebookmodule/view_models/genre_provider.dart';
import 'package:sample2/ebookmodule/view_models/home_provider.dart';

// void main() {
//   runApp(const MyApp());
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => GenreProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
