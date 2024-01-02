import 'package:PharmacyApp/mobile/review_orders.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/mobile/login_register.dart';
import 'package:PharmacyApp/mobile/favorites.dart';
import 'package:PharmacyApp/mobile/intro_page.dart';
import 'package:PharmacyApp/mobile/widget/store.dart';
import 'package:PharmacyApp/mobile/search.dart';
import 'package:PharmacyApp/mobile/home.dart';

import '../shared/medicine.dart';
import 'mobile_home_page.dart';

void main() {
  runApp(PharmacistApp());
}

class PharmacistApp extends StatelessWidget {
  const PharmacistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Medicine Whorehouse',
      initialRoute: LoginRegister.route,
      routes: {
        LoginRegister.route: (context) => LoginRegister(),
        HomePage.route: (context) => HomePage(),
        MainPage.route: (context) => MainPage(),
        Search.route: (context) => Search(),
        Store.route: (context) => Store(),
        Favorites.route: (context) => Favorites(),
        IntroPage.route: (context) => IntroPage(),
        ReviewOrders.route: (context) => ReviewOrders(),
      },
    );
  }
}
