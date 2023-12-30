import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'current_admin.dart';

class AddMedicine extends StatelessWidget {
  const AddMedicine({super.key});

  static const String route = 'route_add_medicine';

  @override
  Widget build(BuildContext context) {
    return const _AddMedicine();
  }
}

class _AddMedicine extends StatefulWidget {
  const _AddMedicine({super.key});

  @override
  State<_AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<_AddMedicine> {
  Map<String, dynamic> Medicine = {
    "s_name": "",
    "t_name": "",
    "category": "",
    "company": "",
    "amount": '0',
    "end_date":
        DateFormat('dd/MM/yyyy').format(DateTime(0000, 00, 00)).toString(),
    "price": '0.0',
  };

  DateTime _selectedDate = DateTime.now();
  var _dateController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Add Medicine'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 100, 100, 40),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required';
                        } else if (!_isValidString(value)) {
                          return r'this should not contain values like !@#$%^';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        Medicine["s_name"] = value!;
                      },
                      decoration: const InputDecoration(
                          label: Text('Enter the Scientific name')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required';
                        } else if (!_isValidString(value)) {
                          return r'this should not contain values like !@#$%^';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        Medicine["t_name"] = value!;
                      },
                      decoration: const InputDecoration(
                          label: Text('Enter the Commercial name')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required';
                        } else if (!_isValidString(value)) {
                          return r'this should not contain values like !@#$%^';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        Medicine["category"] = value!;
                      },
                      decoration: const InputDecoration(
                          label: Text('Enter the Category')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required';
                        } else if (!_isValidString(value)) {
                          return r'this should not contain values like !@#$%^';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        Medicine["company"] = value!;
                      },
                      decoration: const InputDecoration(
                          label: Text('Enter the Manufacture company')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required';
                        } else if (!_isValidString(value)) {
                          return r'this should not contain values like !@#$%^';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onSaved: (value) {
                        Medicine["amount"] = value!;
                      },
                      decoration: const InputDecoration(
                          label: Text('Enter the Quantity Available by box')),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        Medicine["end_date"] = value;
                      },
                      controller: _dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Select Date',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: TextFormField(
                      onSaved: (value) {
                        Medicine["price"] = value!;
                      },
                      decoration:
                          const InputDecoration(label: Text('Enter the Price')),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required';
                        } else if (!_isValidString(value)) {
                          return r'this should not contain values like !@#$%^';
                        } else if (!isNumericWithDot(value)) {
                          return 'Only Double values allowed';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: ElevatedButton(
                    onPressed: _submitform,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(60.0, 40.0)),
                    child: const Text('submit'),
                  ),
                ),
                if (_isLoading)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(color: Colors.amberAccent),
                  )
              ],
            ),
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = '${picked.year}-${picked.month}-${picked.day}';
      });
    }
  }

  void _submitform() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    SnackBar snackbar = SnackBar(
      content: Text(''),
      duration: Duration(seconds: 3),
    );
    _formKey.currentState!.save();
    _switchLoading(true);

    //don't remove the toString() inside this map
    Map<String, String?> MedicineRequestBody = {
      "price": Medicine["price"].toString(),
      "end_date": Medicine["end_date"].toString(),
      "amount": Medicine["amount"].toString(),
      "company": Medicine["company"].toString(),
      "category": Medicine["category"].toString(),
      "t_name": Medicine["t_name"].toString(),
      "s_name": Medicine["s_name"].toString(),
      "_token": userInfo["_token"],
    };
    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/add-medicine'),
        body: MedicineRequestBody,
      );
      _switchLoading(false);
      snackbar = SnackBar(
        content: Text(jsonDecode(response.body)["message"]),
        duration: Duration(seconds: 3),
      );
    } catch (error) {
      print(error);
    }
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _switchLoading(bool bool) {
    setState(() {
      _isLoading = bool;
    });
  }

  bool isNumericWithDot(String input) {
    // Define a regular expression pattern
    RegExp regExp = RegExp(r'^\d+\.\d+$');

    // Check if the input matches the pattern
    return regExp.hasMatch(input);
  }

  bool _isValidString(String input) {
    if (input.contains('!') ||
        input.contains('?') ||
        input.contains('@') ||
        input.contains(r'$') ||
        input.contains('%')) {
      return false;
    }
    return true;
  }
}
