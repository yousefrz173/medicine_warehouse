import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/mobile/medicine_page.dart';
import 'package:PharmacyApp/shared/connect.dart';
import 'package:http/http.dart' as http;

import '../../shared/cart.dart';

class CurrentOrder extends StatefulWidget {
  const CurrentOrder(
      {super.key, required this.id, required this.state, required this.payed});

  final int id;
  final String state;
  final String payed;

  @override
  State<StatefulWidget> createState() =>
      _CurrentOrderState(id: id, state: state, payed: payed);
}

class _CurrentOrderState extends State<CurrentOrder> {
  int id;
  String state;
  String payed;
  late Widget orderDetails;
  late List<Widget> medicinesWidgets;
  late List<Order> orders;

  List<dynamic> medicines = [];

  _CurrentOrderState(
      {required this.id, required this.state, required this.payed});

  final Widget _emptyPage = const Center(
    child: CircularProgressIndicator(),
  );

  void _emptyWidgets() {
    setState(() {
      medicinesWidgets = [
        _emptyPage,
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    orderDetails = Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      elevation: 3,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.purple,
      child: ListTile(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        title: Row(
          children: [
            Text(state),
            Spacer(
              flex: 1,
            ),
            Text(payed),
          ],
        ),
      ),
    );
    _emptyWidgets();
    _refresh();
  }

  Future<void> _loadMedicines() async {
    http.Response response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/order-datails/$id'),
        headers: {'Authorization': 'Bearer ${userInfo["api_token"]}'});
    print(response.body);
    medicines = await jsonDecode(response.body)["medicines"];
    print(medicines);
  }

  Future<void> loadWidgets() async {
    setState(() {
      medicinesWidgets = List.generate(
          medicines.length,
          (index) => Card(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              elevation: 3,
              child: ListTile(
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                title: Row(
                  children: [
                    Text(medicines[index]["s_name"]),
                    Spacer(
                      flex: 1,
                    ),
                    Text(medicines[index]["amount"].toString()),
                  ],
                ),
                tileColor: Colors.purple,
              )));
    });
    print(medicinesWidgets);
    orderDetails = Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      elevation: 3,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.purple,
      child: ListTile(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        title: Row(
          children: [
            Text(state),
            Spacer(
              flex: 1,
            ),
            Text(payed),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    _emptyWidgets();
    await _loadMedicines();
    loadWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(22, 1, 32, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(253, 232, 223, 1.0),
          title: Text('Order ${id} Details'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _refresh();
            });
          },
          child: Column(
            children: [
              Card(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  elevation: 3,
                  child: ListTile(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Row(
                      children: [
                        Text('Medicine'),
                        Spacer(
                          flex: 1,
                        ),
                        Text('Amount'),
                      ],
                    ),
                    tileColor: Colors.purple,
                  )),
              ListView.builder(
                shrinkWrap: true,
                itemCount: medicinesWidgets.length,
                itemBuilder: (context, index) {
                  final Widget item = medicinesWidgets[index];
                  return item;
                },
              ),
              orderDetails,
            ],
          ),
        ));
  }
}
