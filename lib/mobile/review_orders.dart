/*
todo:
   Design
   Connect
*/import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/Cart.dart';

class ReviewOrders extends StatefulWidget {
  static String route = "/mobile/reviewOrders";

  const ReviewOrders({super.key, required this.order});

  final Order order;

  @override
  State<StatefulWidget> createState() {
    return _ReviewOrdersState(order: order);
  }
}

class _ReviewOrdersState extends State<ReviewOrders> {
  _ReviewOrdersState({required this.order});

  void _processOrder(Order order) {}
  Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: Cart.length,
        itemBuilder: (context, index) {
          return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              title: Text(Cart.cartMedicines[index].scientificName),
              onTap: () => () {});
        },
      ),
    );
  }
}
