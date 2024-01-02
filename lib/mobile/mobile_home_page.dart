import 'package:flutter/material.dart';

import '../shared/medicine.dart';

class HomePage extends StatefulWidget {
  static const String route = 'route_home';

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      body: Center(
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
                        child: Image.asset('assets/images/image_processing.gif',
                            fit: BoxFit.contain),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 180),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(width: 140),
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () => {},
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.pending,
                                      color: Colors.white,
                                      size: 55,
                                    ),
                                    Text(
                                      'Orders',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () => {},
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.local_shipping,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    Text(
                                      'New \n Order',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(right: 240),
                  padding: EdgeInsets.only(top: 8),
                  width: 150,
                  height: 30,
                  child: Text(
                    'Recent',
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
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ImportantLists.RecentList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => {},
                          child: Container(
                            padding: EdgeInsets.only(top: 13),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.purple,
                                Colors.deepOrangeAccent,
                              ]),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            height: 25,
                            width: 10,
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
                        );
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisExtent: 60,
                        mainAxisSpacing: 45,
                        childAspectRatio: 3.0,
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
    );
  }
}
