import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'current_user.dart';

class LoginRegister extends StatefulWidget {
  static final String route = 'route_login_register';

  const LoginRegister({Key? key}) : super(key: key);

  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

enum AuthMode { SignUp, Login }

class _LoginRegisterState extends State<LoginRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  bool _obscureText = true;

  bool _isLoading = false;
  final Map<String, String> _authData = {
    'phone': '',
    'password': '',
  };

  final _passwordController = TextEditingController();

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

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
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.contains('.') ||
                        value.contains(',') ||
                        value.contains('-') ||
                        value.contains(' ')) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authData['phone'] = val!;
                    print(_authData['phone']);
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
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
                const SizedBox(height: 20),
                if (_authMode == AuthMode.SignUp)
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    enabled: _authMode == AuthMode.SignUp,
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: _authMode == AuthMode.SignUp
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'The passwords do not match!';
                            }
                            return null;
                          }
                        : null,
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: Text(
                    _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => _submit(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(153, 153, 153, 1.0)),
                  ),
                ),
                TextButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
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
    //10.0.2.2
    _formKey.currentState!.save();
    SnackBar snackBar = SnackBar(content: Text(''));
    _switchLoading(true);
    if (_authMode == AuthMode.Login) {
      http.Response response =
          await http.post(Uri.parse('http://10.0.2.2:8000/api/login'),
              body: jsonEncode({
                "phone": _authData['phone'],
                "password": _authData['password'],
              }),
              headers: {'Content-Type': 'application/json'});
      _switchLoading(false);
      print(response.statusCode);
      if ((jsonDecode(response.body))["statusNumber"] == 200) {
        snackBar = SnackBar(
          content: Text(jsonDecode(response.body)["message"]),
          duration: Duration(seconds: 3),
        );
        print(jsonDecode(response.body)["message"]);

        userInfo = {
          "id": jsonDecode(response.body)["pharmacist_information"]["id"],
          "phone": jsonDecode(response.body)["pharmacist_information"]["phone"],
          "password": jsonDecode(response.body)["pharmacist_information"]
              ["password"],
          "api_token": jsonDecode(response.body)["pharmacist_information"]
              ["api_token"],
        };
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.route, (route) => false);
      } else if ((jsonDecode(response.body))["statusNumber"] == 400) {
        snackBar = SnackBar(
          content: Text(jsonDecode(response.body)["message"]),
          duration: Duration(seconds: 3),
        );
        print((jsonDecode(response.body))["message"]);
      }
    } else {
      //10.0.2.2
      http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/register'),
        body: jsonEncode({
          'phone': _authData['phone'],
          'password': _authData['password'],
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      _switchLoading(false);
      print(response.statusCode);
      if ((jsonDecode(response.body))["statusNumber"] == 200) {
        snackBar = SnackBar(
          content: Text(jsonDecode(response.body)["message"]),
          duration: Duration(seconds: 3),
        );
        print(jsonDecode(response.body)["message"]);
        _switchAuthMode();
      } else if ((jsonDecode(response.body))["statusNumber"] == 400) {
        snackBar = SnackBar(
          content: Text(jsonDecode(response.body)["message"]),
          duration: Duration(seconds: 3),
        );
        print((jsonDecode(response.body))["message"]);
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
