import 'package:flutter/material.dart';

class AddMedicine extends StatelessWidget {
  const AddMedicine({super.key});
  static final String route = 'route_add_medicine';

  @override
  Widget build(BuildContext context) {
    return const _AddMedicine();
  }
}
class _AddMedicine extends StatefulWidget {
  const _AddMedicine({super.key});

  @override
  State<_AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<_AddMedicine> {
  final TextEditingController scintificcontroller = TextEditingController();
  final TextEditingController tradingcontroller = TextEditingController();
  final TextEditingController categorycontroller = TextEditingController();
  final TextEditingController manufactureCompanycontroller =
      TextEditingController();
  final TextEditingController availableQuantitycontroller =
      TextEditingController();
  final TextEditingController expirationDatecontroller =
      TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();

  void _submitform() {
    String scintific = scintificcontroller.text;
    String trading = tradingcontroller.text;
    String Category = categorycontroller.text;
    String ManufactureCompany = manufactureCompanycontroller.text;
    String AvailableQuantity = availableQuantitycontroller.text;
    String ExpirationDate = expirationDatecontroller.text;
    double Price = double.parse(pricecontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Padding(
            padding: EdgeInsets.only(left: 380),
            child: Padding(
              padding: EdgeInsets.only(left: 170, right: 100),
              child: Text('Add Medicine'),
            ),
          ),
        ),
        body: ListView(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 100, 100, 40),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: TextField(
                    controller: scintificcontroller,
                    decoration: const InputDecoration(
                        label: Text('Enter the Scintific name')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: TextField(
                    controller: tradingcontroller,
                    decoration: const InputDecoration(
                        label: Text('Enter the Trade name')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: TextField(
                    controller: categorycontroller,
                    decoration: const InputDecoration(
                        label: Text('Enter the Category')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: TextField(
                    controller: manufactureCompanycontroller,
                    decoration: const InputDecoration(
                        label: Text('Enter theMnaufacture comapny')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: TextField(
                    controller: availableQuantitycontroller,
                    decoration: const InputDecoration(
                        label: Text('Enter the Quantity Available by box')),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: TextField(
                    controller: expirationDatecontroller,
                    decoration: const InputDecoration(
                        label: Text('Enter the Expiration date')),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: TextField(
                    controller: pricecontroller,
                    decoration:
                        const InputDecoration(label: Text('Enter the Price')),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  required;
                  _submitform();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(60.0, 40.0)),
                child: const Text('submit'),
              )
            ],
          ),
        ]));
  }
}
