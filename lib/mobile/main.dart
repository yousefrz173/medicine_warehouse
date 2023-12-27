import 'package:flutter/material.dart';
import 'package:PharmacyApp/mobile/login_register.dart';
import 'package:PharmacyApp/mobile/favorites.dart';
import 'package:PharmacyApp/mobile/intro_page.dart';
import 'package:PharmacyApp/mobile/store.dart';
import 'package:PharmacyApp/mobile/search.dart';
import 'package:PharmacyApp/mobile/home.dart';
import 'package:PharmacyApp/mobile/new_order.dart';
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
      initialRoute: IntroPage.route,
      routes: {
        ProductForm.route : (context) => ProductForm(),
        LoginRegister.route: (context) => LoginRegister(),
        HomePage.route: (context) => HomePage(),
        Search.route: (context) => Search(),
        Store.route: (context) => Store(),
        Favorites.route: (context) => Favorites(),
        IntroPage.route: (context) => IntroPage(),
      },
    );
  }
}
