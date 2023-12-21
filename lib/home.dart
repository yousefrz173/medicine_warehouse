import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/intro_page.dart';
import 'package:flutter_application_1/login_register.dart';
import 'package:http/http.dart' as http;
import 'current_user.dart';
import 'search.dart';
import 'store.dart';
import 'favorites.dart';
import 'medicineList.dart';
import 'my_stock.dart';
import 'current_user.dart';

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
      'title':
          Text('My Stock', style: TextStyle(fontSize: 23, color: Colors.white)),
    },
    {
      'screen': Store(),
      'title':
          Text('Store', style: TextStyle(fontSize: 23, color: Colors.white)),
    },
    {
      'screen': Favorites(),
      'title': Text('Favorites',
          style: TextStyle(fontSize: 23, color: Colors.white)),
    },
  ];
  List<double> amounts = [0.0, 33.0, -8.0, 32.0];
  bool _isLoading = false;

  void BottomNavBarChanger(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void switchLoading(bool b) {
    setState(() {
      _isLoading = b;
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
      drawerScrimColor: Colors.purple.withOpacity(0.5),
      endDrawer: Drawer(
        backgroundColor: Color.fromRGBO(153, 153, 153, 1.0),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            Center(
              child: Container(
                width: 260,
                height: 70,
                child: Text(
                  textAlign: TextAlign.center,
                  '${userInfo["phone"]}',
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              child: OutlinedButton(
                style: ButtonStyle(
                  elevation: MaterialStatePropertyAll(50),
                  backgroundColor: MaterialStatePropertyAll(Colors.purple),
                ),
                onPressed: _LogOut,
                child: Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            if(_isLoading)
            CircularProgressIndicator(),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      appBar: AppBar(
        title: _bottomNavBarScreens[_selectedPageIndex]['title']!,
        actions: [
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
          Builder(builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(60),
              ),
              width: 50,
              height: 50,
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            );
          }),
          SizedBox(width: 10),
        ],
        backgroundColor: Color.fromRGBO(153, 153, 153, 1.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1300,
          width: 500,
          child: Column(
            children: [
              Container(
                  height: 1000,
                  child: _bottomNavBarScreens[_selectedPageIndex]['screen']!),
            ],
          ),
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

  _LogOut() async {
    switchLoading(true);
    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userInfo["api_token"]}"
      },
    );
    switchLoading(false);
    Map<String,dynamic> body = jsonDecode(response.body);
    if (jsonDecode(response.body)["statusNumber"] == 200) {
      print(jsonDecode(response.body)["message"]);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(IntroPage.route, (route) => false);
    } else if (jsonDecode(response.body)["statusNumber"] == 400) {
      print(jsonDecode(response.body)["message"]);
    } else if (jsonDecode(response.body)["statusNumber"] == 403) {
      print(jsonDecode(response.body)["message"]);
    }
  }
}
