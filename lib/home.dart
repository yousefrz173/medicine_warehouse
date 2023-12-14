import 'package:flutter/material.dart';
import 'search.dart';
import 'store.dart';
import 'favorites.dart';
import 'medicineList.dart';
import 'my_stock.dart';

class HomePage extends StatefulWidget {
  static final String route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPageIndex = 0;
  var _selectedPageTitle = 'Home';
  List<Map<String, Widget>> _bottomNavBarScreens = [
    {
      'screen': Center(
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
                        color: Color.fromRGBO(153, 153, 153, 1),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 180),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(width: 100),
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () => {},
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.pending,
                                      color: Colors.white,
                                      size: 55,
                                    ),
                                    Text(
                                      'Shipments',
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
                                  children: [
                                    Icon(
                                      Icons.local_shipping,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    Text(
                                      'New \n Shipment',
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
                      itemCount: PharamacistMedicineList.length,
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
                              PharamacistMedicineList[index].commercialName,
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
      'title':
          Text('Home', style: TextStyle(fontSize: 23, color: Colors.white)),
    },
    {
      'screen': MyStock(),
      'title': Text('My Stock',
          style: TextStyle(fontSize: 19.5, color: Colors.white)),
    },
    {
      'screen': Store(),
      'title':
          Text('Store', style: TextStyle(fontSize: 20.5, color: Colors.white)),
    },
    {
      'screen': Favorites(),
      'title': Text('Favorites',
          style: TextStyle(fontSize: 20, color: Colors.white)),
    },
  ];

  void BottomNavBarChanger(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(BuildContext ctx, String route) {}

  @override
  build(BuildContext context) {
    Map<String, String> map = {'phone_number': ''};
    final routeArguments = ModalRoute.of(context)?.settings.arguments == null
        ? map
        : ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      appBar: AppBar(
        actions: [
          Container(
            child: Row(
              children: [
                _bottomNavBarScreens[_selectedPageIndex]['title']!,
                SizedBox(
                  width: 212,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    Navigator.of(context).pushNamed(Search.route);
                  },
                  child: Icon(
                    Icons.search,
                    size: 45.0,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  focusColor: Colors.purple,
                  onTap: () => {},
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(153, 153, 153, 1.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _bottomNavBarScreens[_selectedPageIndex]['screen']!,
            Container(
              child: Text(
                routeArguments['phone_number']!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: BottomNavBarChanger,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Color.fromRGBO(0, 19, 255, 1.0),
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'My Stock', icon: Icon(Icons.warehouse_outlined)),
          BottomNavigationBarItem(label: 'Store', icon: Icon(Icons.store)),
          BottomNavigationBarItem(
              label: 'Favorites', icon: Icon(Icons.favorite)),
        ],
      ),
    );
  }
}
