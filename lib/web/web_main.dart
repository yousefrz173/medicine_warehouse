import 'package:PharmacyApp/web/web_add_medicine.dart';
import 'package:PharmacyApp/web/web_review_and_edit_orders.dart';
import 'package:PharmacyApp/web/web_store.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/web/web_login.dart';
import 'package:PharmacyApp/web/web_intro_page.dart';
import 'package:PharmacyApp/web/web_search.dart';
import 'package:PharmacyApp/web/web_home.dart';

import 'current_order.dart';
import 'web_home_page.dart';

void main() {
  runApp(AdminWebApp());
}

class AdminWebApp extends StatelessWidget {
  const AdminWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'King Ameer Dashboard',
      initialRoute: LoginWeb.route,
      routes: {
        'http://127.0.0.1:8000/logout': (context) => LoginWeb(),
        LoginWeb.route: (context) => LoginWeb(),
        WebMainPage.route: (context) => WebMainPage(),
        HomePage.route: (context) => HomePage(),
        Search.route: (context) => Search(),
        IntroPage.route: (context) => IntroPage(),
        AddMedicine.route: (context) => AddMedicine(),
        Orders.route: (context) => Orders(),
        CurrentOrder.route: (context) => CurrentOrder(),
        Store.route: (context) => Store(),
      },
    );
  }
}
