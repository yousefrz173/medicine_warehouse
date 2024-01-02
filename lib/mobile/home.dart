import 'package:PharmacyApp/mobile/review_orders.dart';
import 'package:PharmacyApp/shared/connect.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/mobile/intro_page.dart';
import 'package:PharmacyApp/mobile/search.dart';
import 'package:PharmacyApp/mobile/widget/store.dart';
import 'package:PharmacyApp/mobile/favorites.dart';
import 'package:PharmacyApp/mobile/my_chart.dart';
import 'package:PharmacyApp/shared/medicine.dart';
import 'mobile_home_page.dart';

class MainPage extends StatefulWidget {
  static const String route = '/';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<AnimatedListState> listKey = GlobalKey();
  var _selectedPageIndex = 0;
  final _selectedPageTitle = 'Home';
  List<Map<String, Widget>> _bottomNavBarScreens = [
    {
      'screen': HomePage(),
      'title':
          Text('Home', style: TextStyle(fontSize: 23, color: Colors.black)),
    },
    {
      'screen': MyChart(),
      'title':
          Text('My Stock', style: TextStyle(fontSize: 23, color: Colors.black)),
    },
    {
      'screen': Store(),
      'title':
          Text('Store', style: TextStyle(fontSize: 23, color: Colors.black)),
    },
    {
      'screen': ReviewOrders(),
      'title': Text('My Orders',
          style: TextStyle(fontSize: 23, color: Colors.black)),
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
              label: 'My Orders', icon: Icon(Icons.pending_actions)),
        ],
      ),
    );
  }

  _LogOut() async {
    switchLoading(true);
    try {
      Map<String, dynamic> RBody = await Connect.httpLogoutMobile();
      switchLoading(false);
      if (RBody["statusNumber"] == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          IntroPage.route,
          (route) => false,
        );
      } else {
        throw Exception(RBody["message"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
