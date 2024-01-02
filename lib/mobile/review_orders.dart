import 'package:PharmacyApp/mobile/widget/current_order.dart';
import 'package:PharmacyApp/shared/connect.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/cart.dart';

import '../shared/medicine.dart';

class ReviewOrders extends StatefulWidget {
  static String route = "route_review_orders";

  ReviewOrders({super.key});

  @override
  void initState() {}

  @override
  State<StatefulWidget> createState() {
    return _ReviewOrdersState();
  }
}

class _ReviewOrdersState extends State<ReviewOrders> {
  _ReviewOrdersState();

  List<Order> orders = [];
  List<Widget> ordersWidgets = [];

  final Widget _emptyPage = const Center(
    child: CircularProgressIndicator(),
  );

  void _emptyTheWidget() {
    setState(() {
      ordersWidgets = [
        _emptyPage,
      ];
    });
  }

  Future<void> loadOrders() async {
    orders = await ImportantLists.loadOrders(Mode.Mobile);
    setState(() {
      ordersWidgets = List.generate(
          orders.length,
          (index) => Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 3,
                child: ListTile(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Row(
                      children: [
                        Text(orders[index].state),
                        Spacer(
                          flex: 1,
                        ),
                        Text(orders[index].payed),
                      ],
                    ),
                    tileColor: Colors.purple,
                    leading: CircleAvatar(
                      child: Text('${orders[index].id}'),
                    ),
                    onTap: () => setState(() => _orderTapped(
                        orderId: orders[index].id,
                        payed: orders[index].payed,
                        state: orders[index].state))),
              ));
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    _emptyTheWidget();
    loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 1, 32, 1),
      body: RefreshIndicator(
        onRefresh: loadOrders,
        child: ListView.builder(
          itemCount: ordersWidgets.length,
          itemBuilder: (context, index) {
            final item = ordersWidgets[index];
            return item;
          },
        ),
      ),
    );
  }

  _orderTapped(
      {required int orderId, required String state, required String payed}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CurrentOrder(
          id: orderId,
          state: state,
          payed: payed,
        ),
      ),
    );
  }
}
