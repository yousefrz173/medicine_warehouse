import 'package:flutter/material.dart';
import 'web_login.dart';

class IntroPage extends StatelessWidget {
  static final route = 'intro_page_route';

  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _IntroPage();
  }
}

class _IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(130, 130, 130, 20),
              child: Image(
                  width: 170,
                  height: 170,
                  color: Colors.white54,
                  image: AssetImage('assets/icons/caduceus-symbol.png'),
                  fit: BoxFit.fill),
            ),
            const Text(
              textAlign: TextAlign.center,
              'Welcome',
              style: TextStyle(
                  fontFamily: 'Pacifico', fontSize: 30, color: Colors.white54),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Divider(
                color: Colors.grey,
                indent: 300,
                endIndent: 300,
                thickness: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(LoginRegister.route),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(bottom: 13),
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.white),
                child: const Text(
                  textAlign: TextAlign.center,
                  'Get Started',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Divider(
                color: Colors.grey,
                indent: 300,
                endIndent: 300,
                thickness: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
