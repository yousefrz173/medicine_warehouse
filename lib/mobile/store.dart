/*
todo:
   design
   connect
*/
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  static const String route = '/route_store';

  @override
  State<StatefulWidget> createState() {
    return _StoreState();
  }
}

class _StoreState extends State<Store> {
  late List<String> categories = ['null'];
  late List<Widget> categoriesWidgets;

  @override
  void initState() {
    super.initState();
    categoriesWidgets = [const Text('null')];
    loadCategories();
  }

  void loadCategories() async {
    categories = await ImportantLists.loadCategories();
    setState(() {
      categoriesWidgets = List.generate(
          categories.length,
          (index) => ListTile(
                title: Text(categories[index]),
                tileColor: Colors.purple,
              ));
    });
  }

  void _medicinetapped(Medicine medicine) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: loadCategories,
          child: const Icon(Icons.refresh),
        ),
        body: Column(
          children: categoriesWidgets,
        ));
  }
}
