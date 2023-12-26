import 'package:PharmacyApp/shared/shared.dart';
import 'package:PharmacyApp/shared/shared.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:PharmacyApp/web/web_home.dart';
import 'package:http/http.dart' as http;
import 'package:PharmacyApp/web/current_admin.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;

class LoginWeb extends StatefulWidget {
  static final String route = 'route_login_web_register';

  const LoginWeb({Key? key}) : super(key: key);

  @override
  _LoginWebState createState() => _LoginWebState();
}

enum AuthMode { SignUp, Login }

class _LoginWebState extends State<LoginWeb> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _obscureText = true;

  bool _isLoading = false;

  final Map<String, String> _authData = {
    'username': '',
    'password': '',
  };

  final _passwordController = TextEditingController();

  void _switchLoading(bool v) {
    setState(() {
      _isLoading = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(153, 153, 153, 1.0),
        centerTitle: true,
        title: const Text(
          'Enter your info',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(320, 20, 320, 20),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      hintText: 'User Name',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid user name';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _authData['username'] = val!;
                      print(_authData['username']);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(320, 20, 320, 20),
                  child: TextFormField(
                    obscureText: _obscureText,
                    style: TextStyle(color: Colors.white),
                    controller: _passwordController,
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 5) {
                        return 'Please enter a valid password,\n password should contain 5 elements at least';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _authData['password'] = val!;
                      print(_authData['password']);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => _submit(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(153, 153, 153, 1.0)),
                  ),
                ),
                Container(
                  child: _isLoading ? CircularProgressIndicator() : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    SnackBar snackBar = SnackBar(content: Text(''));
    _switchLoading(true);
    var response =
        await http.get(Uri.parse('http://${BackendRoutWeb}:8000/csrf-token'));
    print(response.body);
    print(response.headers);
    String csrfToken = jsonDecode(response.body)["csrf_token"];
    print(csrfToken);
    var loginResponse = await http.post(
      Uri.parse('http://${BackendRoutWeb}:8000/login'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        //'X-CSRF-TOKEN': csrfToken,
      },
      body: {
        "username": _authData['username']!,
        "password": _authData['password']!,
        "_token": csrfToken,
      },
    );
    _switchLoading(false);
    print(loginResponse.statusCode);
    print(loginResponse.body);
    print(loginResponse.headers);
    snackBar = SnackBar(content: Text('${loginResponse.statusCode}'));
    if (loginResponse.statusCode == 200) {
      snackBar = SnackBar(
        content: Text(await loginResponse.body),
        duration: Duration(seconds: 3),
      );
      print(await loginResponse.body);

      // userInfo = {
      //   "id": jsonDecode(response.body)["pharmacist_information"]["id"],
      //   "phone": jsonDecode(response.body)["pharmacist_information"]["phone"],
      //   "password": jsonDecode(response.body)["pharmacist_information"]
      //       ["password"],
      //   "api_token": jsonDecode(response.body)["pharmacist_information"]
      //       ["api_token"],
      // };
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomePage.route, (route) => false);
    } else if (loginResponse.statusCode == 400) {
      snackBar = SnackBar(
        content: Text(await loginResponse.body),
        duration: Duration(seconds: 3),
      );
      print(await loginResponse.body);
    }

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
