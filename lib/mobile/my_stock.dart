import 'package:PharmacyApp/mobile/Widget/MedicineList.dart';
import 'package:PharmacyApp/shared/medicineList.dart';
import 'package:flutter/material.dart';

class MyStock extends StatelessWidget {
  const MyStock({super.key});

  @override
  Widget build(BuildContext context) {
    ImportantLists.loadedMedicinesFromServer();
    return MedicineList(
      medicines: ImportantLists.loadedMedicines,
    );
  }
}
