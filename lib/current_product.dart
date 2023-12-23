import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  static final String route = 'route_product';

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> map = {
      'product_number': Text('0'),
      'product_name': Text(' '),
      'product_details': Text(''),
      'product_image': Image.asset('assets/images/a(5).jpg'),
    };
    final routeArguments = ModalRoute.of(context)?.settings.arguments == null
        ? map
        : ModalRoute.of(context)?.settings.arguments as Map<String, Widget>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Current Product'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 130,
                height: 100,
                child: routeArguments['product_image'],
              ),
            ),
            Container(
              width: 210,
              height: 100,
              child: Row(
                children: [
                  Text('product name:',style: TextStyle(fontSize: 20),),
                  SizedBox(
                    width: 10,
                  ),
                  routeArguments['product_name']!,
                ],
              ),
            ),
            Container(
              width: 210,
              height: 100,
              child: Row(
                children: [
                  Text('product number:',style: TextStyle(fontSize: 20),),
                  SizedBox(
                    width: 10,
                  ),
                  routeArguments['product_number']!,
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20,left: 25),
              width: 500,
              height: 100,
              child: Row(
                children: [
                  Text('product details:'),
                  SizedBox(
                    width: 10,
                  ),
                  routeArguments['product_details']!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
