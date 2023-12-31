import 'package:PharmacyApp/shared/medicineList.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/shared/connect.dart';

enum Mode { Name, Category, none }

class TextFormatting extends StatelessWidget {
  const TextFormatting(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class MedicineList extends StatefulWidget {
  static const route = 'MedicineListPageRoute';
  List<Medicine>? medicines;
  Map<String, List<Medicine>>? categories;
  Mode mode;

  MedicineList(
      {super.key, this.medicines, this.categories, required this.mode});

  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: Icon(Icons.refresh_sharp),
          onPressed: () {
            setState(() {
              ImportantLists.loadedMedicinesFromServer();
              widget.mode == Mode.Category
                  ? widget.categories = ImportantLists.loadedMedicinesByCategory
                  : widget.medicines = ImportantLists.loadedMedicines;
              widget.medicines = ImportantLists.loadedMedicines;
            });
          },
        ),
        backgroundColor: Color.fromRGBO(255, 243, 224, 1),
      ),
      body: ListView.builder(
        itemCount: widget.mode == Mode.Category
            ? widget.categories!.keys.length ?? 0
            : widget.medicines!.length ?? 0,
        itemBuilder: (context, index) {
          final item = widget.mode == Mode.Category
              ? widget.categories!.keys.toList()[index]
              : widget.medicines![index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {},
                title: widget.mode == Mode.Category
                    ? widget.categories == null
                        ? Text('No Results')
                        : Text('${item!}')
                    : widget.medicines == null
                        ? Text('No Results')
                        : Text('${widget.medicines![index]}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
