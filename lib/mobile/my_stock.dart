import 'package:PharmacyApp/shared/medicineList.dart';
import 'package:flutter/material.dart';

class MyStock extends StatefulWidget {
  static String route = '/moblie/myStock';

  const MyStock({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyStockState();
  }
}

class _MyStockState extends State<MyStock> {
  @override
  Widget build(BuildContext context) {
    loadMedicinesFromServer();
    return Scaffold(body: Text('Null'));
  }
}
