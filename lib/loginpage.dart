import 'package:flutter/material.dart';
import 'home.dart';

class Loginpage extends StatelessWidget {
  static final route = 'route_login';

  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return _LoginPage();
  }
}

class _LoginPage extends StatelessWidget {
  TextEditingController loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      appBar: AppBar(
        title: const Text('Login to pharmacy app'),
        backgroundColor: Color.fromRGBO(153, 153, 153, 1.0),
      ),
      body: Container(
        color: Color.fromRGBO(22, 1, 32, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  controller: loginController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      labelText: 'Enter your phone number',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Divider(
                color: Colors.grey,
                indent: 50,
                endIndent: 50,
                thickness: 3,
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePage.route,
                  (route) => false,
                  arguments: {
                    'phone_number': loginController.text,
                  },
                ),
                child: Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
