/*
todo:
   design
   connect
*/

import 'package:PharmacyApp/shared/medicine.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/medicineList.dart';
import 'package:PharmacyApp/mobile/home.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  static const String route = '/route_store';

  @override
  State<StatefulWidget> createState() {
    return _StoreState();
  }
}

class _StoreState extends State<Store> {
  late List<Medicine> medicines;

  @override
  void initState() {
    super.initState();
    ImportantLists.loadMedicinesFromServer();
    medicines = ImportantLists.loadedMedicines;
  }

  void _medicinetapped(Medicine medicine) {}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            ImportantLists.loadMedicinesFromServer();
            medicines = ImportantLists.loadedMedicines;
          });
        },
      ),
      body: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              // child: Card(
              child: ListTile(
                  onTap: () => _medicinetapped(medicines[index]),
                  title: Text(medicines[index].commercialName)

                  // ),

                  ));
        },
      ),
    );
  }
}
