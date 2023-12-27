import 'package:PharmacyApp/shared/connect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:PharmacyApp/mobile/home.dart';
import 'package:PharmacyApp/mobile/current_user.dart';

class LoginRegister extends StatefulWidget {
  static const String route = 'route_login_register';

  const LoginRegister({super.key});

  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

enum AuthMode { SignUp, Login }

class _LoginRegisterState extends State<LoginRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;

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
      backgroundColor: const Color.fromRGBO(22, 1, 32, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(153, 153, 153, 1.0),
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
                  obscureText: _passwordObscureText,
                  style: const TextStyle(color: Colors.white),
                  controller: _passwordController,
                  cursorColor: Colors.indigo,
                  decoration: InputDecoration(
                    prefixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordObscureText = !_passwordObscureText;
                        });
                      },
                      child: Icon(_passwordObscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.white),
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
                    obscureText: _confirmPasswordObscureText,
                    style: const TextStyle(color: Colors.white),
                    enabled: _authMode == AuthMode.SignUp,
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordObscureText = !_passwordObscureText;
                          });
                        },
                        child: Icon(_passwordObscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(color: Colors.white),
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
                  onPressed: () => _submit(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(153, 153, 153, 1.0)),
                  ),
                  child: Text(
                    _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: _switchAuthMode,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'} INSTEAD'),
                ),
                Container(
                  child: _isLoading ? const CircularProgressIndicator() : null,
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
    Map<String, dynamic> respondBody = {};

    SnackBar snackBar = const SnackBar(content: Text(''));
    _switchLoading(true);
    try {
      if (_authMode == AuthMode.Login) {
        respondBody = await Connect.http_login_mobile(
          phone: _authData['phone']!,
          password: _authData['password']!,
        );
        _switchLoading(false);

        if (respondBody["statusNumber"] == 200) {
          snackBar = SnackBar(
            content: Text(respondBody["message"]),
            duration: Duration(seconds: 3),
          );
          userInfo = {
            "id": respondBody["pharmacist_information"]["id"],
            "phone": respondBody["pharmacist_information"]["phone"],
            "password": respondBody["pharmacist_information"]["password"],
            "api_token": respondBody["pharmacist_information"]["api_token"],
          };
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomePage.route,
            (route) => false,
          );
        } else {
          throw Exception(respondBody["message"]);
        }
      } else {
        //BackendRout
        respondBody = await Connect.http_register_mobile(
          phone: _authData['phone']!,
          password: _authData['password']!,
        );
        _switchLoading(false);
        if (respondBody["statusNumber"] == 200) {
          snackBar = SnackBar(
            content: Text(respondBody["message"]),
            duration: const Duration(seconds: 3),
          );
          print(respondBody["message"]);
          _switchAuthMode();
        } else {
          throw Exception(respondBody["message"]);
        }
      }
    } catch (e) {
      snackBar = SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 3),
      );
      print(e.toString());
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
