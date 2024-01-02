import 'dart:async';

import 'package:PharmacyApp/shared/Cart.dart';
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/web/current_order.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/connect.dart';

class Orders extends StatelessWidget {
  static const String route = "route_review_edit_orders";

  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return _Orders();
  }
}

class _Orders extends StatefulWidget {
  @override
  State<_Orders> createState() => _OrdersState();
}

class _OrdersState extends State<_Orders> {
  late List Orders = [];
  late List<Widget> OrdersWidgets;
  final Widget _emptyPage = const Center(child: CircularProgressIndicator());

  void emptyTheWidget(){
    setState(() {
      OrdersWidgets = [_emptyPage];
    });
  }

  Map<String, dynamic> _currentOrder = {
    'state': 'preparation',
    'payed': 'un-payed',
    'medicines': [],
  };
  GlobalKey<AnimatedListState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    emptyTheWidget();
    _refresh();
  }

  Future<void> _refresh() async {
    emptyTheWidget();
    _getOrders();
  }

  void _getOrders() async {
    try {
      var rBody = await Connect.getOrdersAdmin();
      setState(() {
        Orders = rBody["orders"];
        _loeadOrders();
      });
    } catch (error) {
      print(error);
    }
  }

  void _loeadOrders() {
    OrdersWidgets = List.generate(
        Orders.length,
        (index) => Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                style: ListTileStyle.list,
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.purple,
                title: Text(
                    'Order for pharmacist ${Orders[index]["pharmacist_id"]}'),
                leading: CircleAvatar(
                  // You can customize the leading widget (e.g., an image)
                  child: Text('${Orders[index]["id"]}'),
                ),
                onTap: () async {
                  _currentOrder = {
                    'id': Orders[index]["id"],
                    'state': Orders[index]["state"],
                    'payed': Orders[index]["payed"],
                    'medicines': await _getOrderDetails(Orders[index]["id"])
                  };
                  CurrentOrder.selecteditem1 = Orders[index]["payed"];
                  CurrentOrder.selecteditem = Orders[index]["state"];
                  Navigator.of(context)
                      .pushNamed(CurrentOrder.route, arguments: _currentOrder);
                },
              ),
            ));
  }

  Future<List> _getOrderDetails(int orderNum) async {
    try {
      var rBody =
          await Connect.orderDetails(orderNumber: orderNum, mode: Mode.Web);
      return rBody["medicines"];
    } catch (error) {
      print(error);
    }
//todo: fix this error
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(253, 232, 223, 1.0),
        title: Text('Review Orders'),
      ),
      body: ListView.builder(
        key: key,
        itemCount: OrdersWidgets.length,
        itemBuilder: (BuildContext context, int index) {
          final item = OrdersWidgets[index];
          return item;
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh_sharp),
        onPressed: () async {
          _refresh();
        },
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
