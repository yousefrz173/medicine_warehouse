import 'package:PharmacyApp/shared/medicine.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/cart.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key, required this.medicine});

  final Medicine medicine;

  @override
  State<StatefulWidget> createState() {
    return _MedicinePageState(medicine: medicine);
  }
}

class _MedicinePageState extends State<MedicinePage> {
  _MedicinePageState({required this.medicine});

  final Medicine medicine;

  Widget formattedRow({required String title, required String value}) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
          tileColor: Colors.purple,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          title: Row(
            children: [Text(title), const Spacer(), Text(value)],
          )),
    );
  }

  int get amountInCart {
    int indexInCart = Cart.getMedicineIndexInCart(medicine: medicine);
    if (indexInCart == -1) return 0;
    return Cart.cartQuantities[indexInCart];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(22, 1, 32, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(253, 232, 223, 1.0),
          title: Text('Medicine Info'),
        ),
        body: ListView(
      children: [
        formattedRow(title: 'commercial name', value: medicine.commercialName),
        formattedRow(title: 'scientific name', value: medicine.scientificName),
        formattedRow(title: 'company', value: medicine.company),
        formattedRow(title: 'category', value: medicine.category),
        formattedRow(title: 'price ', value: medicine.price.toStringAsFixed(2)),
        ElevatedButton(
            onPressed: () {},
            child: const ListTile(title: Center(child: Text('Add to Cart'))))
      ],
    ));
  }
}
