import 'dart:convert';
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/web/web_add_medicine.dart';
import 'package:PharmacyApp/web/web_review_and_edit_orders.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:PharmacyApp/web/web_intro_page.dart';
import 'package:PharmacyApp/web/current_admin.dart';
import 'package:PharmacyApp/web/web_search.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> GridKey = GlobalKey();
  var _selectedPageIndex = 0;
  var _selectedPageTitle = 'Home';

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
    List<Map<String, Widget>> _bottomNavBarScreens = [
      {
        'screen': Center(
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
        'title':
            Text('Home', style: TextStyle(fontSize: 23, color: Colors.black)),
      },
      {
        'screen': Scaffold(),
        'title':
            Text('Store', style: TextStyle(fontSize: 23, color: Colors.black)),
      },
    ];
    Map<String, String> map = {'phone_number': ''};
    final routeArguments = ModalRoute.of(context)?.settings.arguments == null
        ? map
        : ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return Scaffold(
      key: GridKey,
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
                  '${userInfo["username"]}',
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
            if (_isLoading) CircularProgressIndicator(),
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
              color: Colors.black,
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
        backgroundColor: Color.fromRGBO(253, 232, 223, 1.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1300,
          alignment: Alignment.center,
          width: 1500,
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
          BottomNavigationBarItem(label: 'Store', icon: Icon(Icons.store)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            ImportantLists.RecentList = ImportantLists.RecentList;
          });
        },
      ),
    );
  }

  _LogOut() async {
    SnackBar snackBar = SnackBar(content: Text(''));
    switchLoading(true);
    http.Response response = await http.get(
      Uri.parse('http://127.0.0.1:8000/logout'),
    );
    switchLoading(false);
    print(response.statusCode);
    Map<String, dynamic> body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      snackBar = SnackBar(
        content: Text(body["message"]),
        duration: Duration(seconds: 3),
      );
      if (body["statusNumber"] != 200) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      print(jsonDecode(response.body)["message"]);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(IntroPage.route, (route) => false);
    } else if (response.statusCode >= 400) {
      snackBar = SnackBar(
        content: Text(body["message"]),
        duration: Duration(seconds: 3),
      );
      print(jsonDecode(response.body)["message"]);
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
