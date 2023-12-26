import 'package:PharmacyApp/web/web_add_medicine.dart';
import 'package:flutter/material.dart';
import 'web_login.dart';
import 'web_intro_page.dart';
import 'web_search.dart';
import 'web_home.dart';

void main() {
  runApp(AdminWebApp());
}

class AdminWebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Medicine Whorehouse',
      initialRoute: HomePage.route,
      routes: {
        Login.route: (context) => Login(),
        HomePage.route: (context) => HomePage(),
        Search.route: (context) => Search(),
        IntroPage.route: (context) => IntroPage(),
        AddMedicine.route: (context) => AddMedicine(),
      },
    );
  }
}
