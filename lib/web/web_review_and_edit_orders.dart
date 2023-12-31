import 'dart:async';
import 'dart:convert';

import 'package:PharmacyApp/web/current_order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Map<String, dynamic> _currentOrder = {
    'state': 'preparation',
    'payed': 'un-payed',
    'medicines': [],
  };
  GlobalKey<AnimatedListState> key = GlobalKey();
  late http.Response response;

  @override
  void initState() {
    super.initState();
    OrdersWidgets = [
      const Center(
        child: CircularProgressIndicator(),
      )
    ];
  }

  void _getOrders() async {
    try {
      response = await http.get(Uri.parse('http://127.0.0.1:8000/getorders'));
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        setState(() {
          Orders = jsonDecode(response.body)["orders"];
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future<List> _getOrderDetails(int orderNum) async {
    late List temp;
    try {
      var response = await http.get(
        Uri.parse('http://127.0.0.1:8000/order-datails/$orderNum'),
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        temp = jsonDecode(response.body)["medicines"];
      }
    } catch (error) {
      print(error);
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      _getOrders();
    });
    print(Orders);
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(253, 232, 223, 1.0),
        title: Text('Review Orders'),
      ),
      body: Orders == []
          ? PageIndicator()
          : ListView.builder(
              key: key,
              itemCount: Orders.length,
              itemBuilder: (BuildContext context, int index) {
                final item = Orders[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    style: ListTileStyle.list,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    tileColor: Colors.purple,
                    title:
                        Text('Order for pharmacist ${item["pharmacist_id"]}'),
                    leading: CircleAvatar(
                      // You can customize the leading widget (e.g., an image)
                      child: Text('${item["id"]}'),
                    ),
                    onTap: () async {
                      togglePageIndicator();
                      _currentOrder = {
                        'id': item["id"],
                        'state': item["state"],
                        'payed': item["payed"],
                        'medicines': await _getOrderDetails(item["id"])
                      };
                      togglePageIndicator();
                      CurrentOrder.selecteditem1 = item["payed"];
                      CurrentOrder.selecteditem = item["state"];
                      Navigator.of(context).pushNamed(CurrentOrder.route,
                          arguments: _currentOrder);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: Visibility(
        visible: showPageIndicator,
        child: PageIndicator(),
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
