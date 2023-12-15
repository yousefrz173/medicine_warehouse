import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
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
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
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
                    _authData['phone_number'] = val!;
                    print(_authData['phone_number']);
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordController,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
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
                  onPressed: _submit,
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
                  child: Text(
                    _authData['password']!,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    if (_authMode == AuthMode.Login) {
      http.Response response = await http.post(
        Uri.parse(
            'http://127.0.0.1:8000/api/login?phone=${_authData['phone']}&password=${_authData['password']}'),
      );
      if (response.statusCode == 200) {
        print('sucess!');
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.route, (route) => false);
      }
    } else {
      http.Response response = await http.post(Uri.parse(
          'http://127.0.0.1:8000/api/register?phone=${_authData['phone']}&password=${_authData['password']}'));
      if (response.statusCode == 200) {
        print('sucess!');
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.route, (route) => false);
      } else if (response.statusCode == 400) {
        print('failed');
        return;
      }
    }
  }
}
