import 'package:PharmacyApp/shared/shared.dart';
import 'package:flutter/material.dart';

class Store extends StatelessWidget{
  const Store({super.key});
  static const String route = '/route_store';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      body: Container(
        child: Text('Fuck', style: TextStyle(color: Colors.white,fontSize: 40),),
      ),
    );
  }

}