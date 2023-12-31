import 'package:PharmacyApp/mobile/Widget/MedicineList.dart';
import 'package:PharmacyApp/shared/medicineList.dart';
import 'package:flutter/material.dart';

class MyChart extends StatelessWidget {
  static const String route = 'route_chart';
  const MyChart({super.key});

  @override
  Widget build(BuildContext context) {
    ImportantLists.loadedMedicinesFromServer();
    return Scaffold();
  }
}
