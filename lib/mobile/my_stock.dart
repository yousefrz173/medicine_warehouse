import 'package:PharmacyApp/shared/cart.dart';
import 'package:PharmacyApp/shared/connect.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/medicine.dart';

class MyStock extends StatefulWidget {
  const MyStock({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyStockState();
  }
}

class _MyStockState extends State<MyStock> {
  late List<Order>? orders;
  late List<Widget> ordersWidgets;

  @override
  void initState() {
    super.initState();
    ordersWidgets = [Text('null')];
    loadOrders();
  }

  Widget emptyOrderWidget() {
    return Text('null');
  }

  void loadOrders() async {
    orders = await Cart.loadOrders();
    setState(() {
      if (orders == null) {
        ordersWidgets = [emptyOrderWidget()];
        return;
      }
      ordersWidgets = List.generate(
          orders!.length,
          (index) => ListTile(
                title: Text('${orders![index]}'),
                tileColor: Colors.purple,
              ));
    });
  }

  void _orderTapped(Order order){

  }

  @override
  Widget build(BuildContext context) {
    return const Text('null');
  }
}
