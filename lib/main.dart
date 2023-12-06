import 'package:flutter/material.dart';
import 'favorites.dart';
import 'intro_page.dart';
import 'loginpage.dart';
import 'user_info.dart';
import 'store.dart';
import 'search.dart';
import 'home.dart';

void main() {
  runApp(MedicineWhorehouseApp());
}

class MedicineWhorehouseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Medicine Whorehouse',
      initialRoute: IntroPage.route,
      routes: {
        '/': (context) => HomePage(),
        Search.route: (context) => Search(),
        Store.route: (context) => Store(),
        UserInfo.route: (context) => UserInfo(),
        Favorites.route: (context) => Favorites(),
        IntroPage.route: (context) => IntroPage(),
        Loginpage.route: (context) => Loginpage(),
      },
    );
  }
}
