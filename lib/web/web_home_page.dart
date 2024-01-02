import 'package:flutter/material.dart';

import '../shared/medicine.dart';
import 'web_add_medicine.dart';
import 'web_review_and_edit_orders.dart';

class HomePage extends StatefulWidget {
  static const route = 'home_page_route';

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 1350,
          child: Column(
            children: [
              Container(
                width: 1300,
                height: 220,
                color: Color.fromRGBO(253, 232, 223, 1.0),
                child: Image.asset(
                  'assets/images/image_processing.gif',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () =>
                        Navigator.of(context).pushNamed(Orders.route),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pending,
                          color: Colors.purple,
                          size: 55,
                        ),
                        Text(
                          'Orders',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      Navigator.of(context).pushNamed(AddMedicine.route);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: Colors.purple,
                          size: 40,
                        ),
                        Text(
                          'New \n Medicine',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment(-8, 0),
                padding: EdgeInsets.only(top: 8),
                width: 150,
                height: 30,
                child: Text(
                  'Recent',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 380,
                height: 400,
                child: GridView.builder(
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: ImportantLists.RecentList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => {},
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.purple,
                            Colors.deepOrangeAccent,
                          ]),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 25,
                        child: Center(
                          child: Text(
                            ImportantLists.RecentList[index].commercialName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 60,
                    mainAxisSpacing: 45,
                    childAspectRatio: 3.0,
                    crossAxisSpacing: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
