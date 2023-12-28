import 'package:PharmacyApp/shared/medicineList.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/shared/connect.dart';
class MedicineList extends StatelessWidget {
  static const route = 'MedicineListPageRoute';
  List<Medicine> medicines;

  MedicineList({super.key, required this.medicines});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {},
                title: Text(medicines[index].commercialName),
              ),
            ),
          );

          // return ListTile(
//   title: Text(medicineIDs[index]),
//   // Add more customization as needed
// );
        },
      ),
    );
  }
}

class TextFormatting extends StatelessWidget {
  const TextFormatting(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
