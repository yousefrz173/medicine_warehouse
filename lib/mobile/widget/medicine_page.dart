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
      child: ListTile(
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
