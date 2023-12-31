import 'package:PharmacyApp/mobile/Widget/MedicineList.dart';
import 'package:PharmacyApp/shared/medicineList.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  static const String route = '/route_store';

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    ImportantLists.loadedMedicinesFromServer();
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      body: MedicineList(
        mode: Mode.Category,
        categories: ImportantLists.loadedMedicinesByCategory,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }

  bool showPageIndicator = false;

  void togglePageIndicator() {
    setState(() {
      showPageIndicator = !showPageIndicator;
    });
  }
}

class PageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => Positioned(
            top: MediaQuery.of(context).size.height * 0.5 - 50,
            left: MediaQuery.of(context).size.width * 0.5 - 50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.withOpacity(0.7),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
