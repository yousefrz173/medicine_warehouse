import 'dart:async';

import 'package:PharmacyApp/shared/medicine.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/cart.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key, required this.medicine, required this.mode,this.onPopped});

  final VoidCallback? onPopped;
  final Medicine medicine;
  final Mode mode;
  @override
  State<StatefulWidget> createState() {
    return _MedicinePageState(medicine: medicine,mode: mode);
  }
}

class _MedicinePageState extends State<MedicinePage> {
  final VoidCallback? onPopped;

  _MedicinePageState({required this.medicine, required this.mode, this.onPopped});
  final Mode mode;
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

  int get _amountInCart {
    OrderedMedicine? cartMedicine = Cart.medicinesMap[medicine.id];
    if (cartMedicine == null) return 0;
    return cartMedicine.orderedAmount;
  }

  bool userWantThisMedicine = false;

  late Widget currentWidget;

  void _addToCartPressed() {
    setState(() {
      userWantThisMedicine = true;
      currentWidget = wantedWidget;
      Cart.addMedicine(medicine: medicine, amount: 1);
      amountInCartCurrently = _amountInCart;
    });
  }

  bool isonLongPressUp = false;
  Timer? timer;

  Widget get adder {
    return GestureDetector(
      onLongPressUp: () {
        timer?.cancel();
      },
      onLongPress: () {
        timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
          if (!isonLongPressUp) {
            setState(() {
              Cart.addMedicine(medicine: medicine, amount: 1);
            });
          }
        });
      },
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              Cart.addMedicine(medicine: medicine, amount: 1);
            });
          },
          child: const Icon(Icons.add)),
    );
  }

  Widget get remover {
    return GestureDetector(
      onLongPress: () {
        {
          timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
            if (!isonLongPressUp) {
              setState(() {
                Cart.removeMedicine(medicine: medicine, amount: 1);
              });
            }
          });
        }
      },
      onLongPressUp: () {
        timer?.cancel();
      },
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              Cart.removeMedicine(medicine: medicine, amount: 1);
            });
          },
          child: const Icon(Icons.remove)),
    );
  }

  Widget get wantedWidget => Card(
      child: Row(
        children: [
          adder,
          remover,
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Cart.removeMedicine(medicine: medicine);
                });
              },
              child: const Icon(Icons.refresh)),
          const Spacer(),
          Text("amount In Cart: $_amountInCart"),
          const Spacer()
        ],
      ));

  late int amountInCartCurrently;

  @override
  void initState() {
    super.initState();
    //

    amountInCartCurrently = _amountInCart;
  }

  @override
  Widget build(BuildContext context) {
    if (!userWantThisMedicine) {
      amountInCartCurrently = _amountInCart;
      userWantThisMedicine = (amountInCartCurrently > 0);
    }
    if (!userWantThisMedicine) {
      currentWidget = ElevatedButton(
          onPressed: _addToCartPressed,
          child: const ListTile(title: Center(child: Text('Add to Cart'))));
    } else {
      currentWidget = wantedWidget;
    }
    if (userWantThisMedicine) {
      Cart.medicinesMap[medicine.id]?.checkForAmountOverFlow();
    }
    return Scaffold(
        backgroundColor: const Color.fromRGBO(22, 1, 32, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(253, 232, 223, 1.0),
          title: const Text('Medicine Info'),
        ),
        body: ListView(
          children: [
            formattedRow(
                title: 'commercial name', value: medicine.commercialName),
            formattedRow(
                title: 'scientific name', value: medicine.scientificName),
            formattedRow(title: 'company', value: medicine.company),
            formattedRow(title: 'category', value: medicine.category),
            formattedRow(
                title: 'price ', value: medicine.price.toStringAsFixed(2)),
            formattedRow(
                title: 'available amount ',
                value: medicine.availableAmount.toStringAsFixed(2)),
            currentWidget,
          ],
        ));
  }
}
