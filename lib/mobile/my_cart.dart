import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/mobile/medicine_page.dart';
import 'package:PharmacyApp/shared/cart.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyCartState();
  }
}

class _MyCartState extends State<MyCart> {
  late List<OrderedMedicine> medicines;

  late List<Widget> cartWidgets;
  late final Widget emptyPage;

  _MyCartState();

  @override
  void initState() {
    super.initState();
    emptyPage = const Center(
      child: CircularProgressIndicator(),
    );
    cartWidgets = [emptyPage];
    _refresh();
  }

  void _medicineTapped() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MedicinePage(
        medicine: choosedMedicine,
        onPopped: _refresh,
        mode: Mode.Mobile,
      ),
    ));
  }

  void loadMedicines() {
    medicines = Cart.medicinesList;
    loadWidgets();
  }

  late OrderedMedicine choosedMedicine;

  Widget formattedMedicineRow({required OrderedMedicine medicine}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        title: Row(
          children: [
            Text(medicine.commercialName),
            const Spacer(),
            Text(medicine.orderedAmount.toString())
          ],
        ),
        // tileColor: Colors.purple,
        onTap: () {
          choosedMedicine = medicine;
          _medicineTapped();
        },
      ),
    );
  }

  void loadWidgets() => setState(() {
        cartWidgets = List.generate(medicines.length,
            (index) => formattedMedicineRow(medicine: medicines[index]));
      });

  void _refresh() async {
    loadMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) setState(() {});
      },
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(22, 1, 32, 1),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(253, 232, 223, 1.0),
            title: const Text("Cart Medicines"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _refresh,
            child: const Icon(Icons.refresh),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              _refresh();
            },
            child: ListView(
              children: [
                Card(
                  color: Colors.red,
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Row(
                      children: [
                        Text("Total Price Of Cart is"),
                        const Spacer(),
                        Text("${Cart.cartTotalPrice.toString()}\$")
                      ],
                    ),
                    // tileColor: Colors.purple,
                    onTap: () {
                      // choosedMedicine = medicine;
                      // _medicinetapped();
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Cart.order();
                        medicines = [];
                        cartWidgets = [];
                        _refresh();
                      });
                    },
                    child: const Text("Buy")),
                Column(
                  children: cartWidgets,
                ),
              ],
            ),
          )),
    );
  }
}
