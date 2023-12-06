import 'package:flutter/material.dart';
import 'package:medicine_warehouse/favorites.dart';
import 'package:medicine_warehouse/intro_page.dart';
import 'package:medicine_warehouse/loginpage.dart';
import 'package:medicine_warehouse/user_info.dart';
import 'package:medicine_warehouse/store.dart';
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
