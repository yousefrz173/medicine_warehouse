import 'package:PharmacyApp/shared/shared.dart';
import 'package:PharmacyApp/web/web_add_medicine.dart';
import 'package:flutter/material.dart';
import 'Package:/PharmacyApp/web/web_login.dart';
import 'Package:/PharmacyApp/web/web_intro_page.dart';
import 'Package:/PharmacyApp/web/web_search.dart';
import 'Package:/PharmacyApp/web/web_home.dart';

void main() {
  runApp(AdminWebApp());
}

class AdminWebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Medicine Whorehouse',
      initialRoute: LoginWeb.route,
      routes: {
        LoginWeb.route: (context) => LoginWeb(),
        HomePage.route: (context) => HomePage(),
        Search.route: (context) => Search(),
        IntroPage.route: (context) => IntroPage(),
        AddMedicine.route: (context) => AddMedicine(),
      },
    );
  }
}
