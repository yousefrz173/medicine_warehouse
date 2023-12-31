import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/connect.dart';

class CurrentOrder extends StatefulWidget {
  static const String route = "route_current_order";

  static String? selecteditem = 'preparation';
  static String? selecteditem1 = 'not-paid';

  const CurrentOrder({super.key});

  @override
  State<CurrentOrder> createState() => _OrdersState();
}

class _OrdersState extends State<CurrentOrder> {
  List<String?> itemsList = ['preparation', 'send', 'received'];
  List<String?> itemList = ['not-paid', 'paid'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = {
      'id': 0,
      'state': 'preparation',
      'payed': 'not-paid',
      'medicines': [
        {
          's_name': 'scientefic name',
          'amount': 0,
        }
      ]
    };
    final routeArguments = ModalRoute.of(context)?.settings.arguments == null
        ? map
        : ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 130, 110, 142),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 159, 147, 168),
        title: const Text('Orders'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 65,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Medicine',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Quantity',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: routeArguments['medicines'].length,
              itemBuilder: (BuildContext context, int index) {
                final item = routeArguments['medicines'][index];
                return Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 70,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          '${item["s_name"]}',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                      Spacer(flex: 1),
                      Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: Text(
                          '${item["amount"]}',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: DropdownButton<String>(
                      value: CurrentOrder.selecteditem,
                      items: itemsList
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child:
                                  Text(item!, style: TextStyle(fontSize: 20))))
                          .toList(),
                      onChanged: (item) =>
                          setState(() => CurrentOrder.selecteditem = item)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: DropdownButton<String>(
                        value: CurrentOrder.selecteditem1,
                        items: itemList
                            .map((item1) => DropdownMenuItem(
                                value: item1,
                                child: Text(item1!,
                                    style: TextStyle(fontSize: 20))))
                            .toList(),
                        onChanged: (item1) =>
                            setState(() => CurrentOrder.selecteditem1 = item1)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.purple)),
              onPressed: () {
                _updateOrder(routeArguments);
              },
              child: Text(
                'Change Order State',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: showPageIndicator,
        child: PageIndicator(),
      ),
    );
  }

  Future _updateOrder(Map<String, dynamic> routeArguments) async {
    SnackBar snackBar = SnackBar(
      content: Text(''),
      duration: Duration(seconds: 3),
    );

    try {
      togglePageIndicator();
      Map<String, dynamic> responseBody = await Connect.httpchangestateAdmin(
        id: routeArguments['id'].toString(),
        state: CurrentOrder.selecteditem.toString(),
        payed: CurrentOrder.selecteditem1.toString(),
      );
      togglePageIndicator();
      snackBar = SnackBar(
        content: Text(responseBody["message"]!),
        duration: const Duration(seconds: 3),
      );
    } catch (error) {
      print(error.toString());
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
