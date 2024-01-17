import 'dart:typed_data';
import 'dart:io';
import 'package:PharmacyApp/mobile/review_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../shared/cart.dart';
import '../shared/medicine.dart';
import 'package:PharmacyApp/mobile/current_order.dart';

class HomePage extends StatefulWidget {
  static const String route = 'route_home';

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Order> orders = [];
  List<Widget> ordersWidgets = [];
  Uint8List imageData = Uint8List(8);
  final Widget _emptyPage = const Center(
    child: CircularProgressIndicator(),
  );

  Future<void> loadImage(String imgPath) async{
    imageData = await rootBundle.load(imgPath).then((ByteData data) => data.buffer.asUint8List());
  }
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
                color: Colors.purple,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 3,
                child: InkWell(
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Text('${orders[index].id}'),
                          backgroundColor: Colors.purpleAccent,
                        ),
                        Text(orders[index].state,style: TextStyle(fontSize: 20),),
                        Text(orders[index].payed),
                      ],
                    ),
                    onTap: () => setState(() => _orderTapped(
                        orderId: orders[index].id,
                        payed: orders[index].payed,
                        state: orders[index].state))),
              ));
    });
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

  Future<void> _refresh() async {
    _emptyTheWidget();
    loadOrders();
  }

  @override
  void initState() {
    super.initState();
    loadImage('assets/images/image_processing.gif');
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Center(
          child: Container(
            width: 700,
            height: 1000,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 1100,
                    child: Stack(
                      children: [
                        Container(
                          width: 900,
                          height: 220,
                          color: Color.fromRGBO(255, 234, 224, 1),
                          child:
                          Image.asset(
                              'assets/images/image_processing.gif',
                              fit: BoxFit.contain),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 240),
                    width: 150,
                    height: 30,
                    child: Text(
                      'My orders',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 380,
                      height: 400,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: ordersWidgets.length,
                        itemBuilder: (context, index) {
                          final item = ordersWidgets[index];
                          return item;
                        },
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          mainAxisExtent: 160,
                          mainAxisSpacing: 45,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 35,
                        ),
                      )),
                  SizedBox(
                    width: 500,
                    height: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
