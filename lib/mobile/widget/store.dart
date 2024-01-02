/*
todo:
   design
   connect
*/
import 'package:PharmacyApp/shared/cart.dart';
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/mobile/widget/category_store.dart';

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
    categoriesWidgets = [
      const Center(
        child: CircularProgressIndicator(),
      )
    ];
    loadCategories();
  }

  void _categoryTapped({required String categoryName}) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CategoryStore(category: categoryName)),
    );
  }

  Future<void> loadCategories() async {
    categories = await ImportantLists.loadCategories(Mode.Mobile);
    setState(() {
      categoriesWidgets = List.generate(
          categories.length,
          (index) => Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 3,
                child: ListTile(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(categories[index]),
                    tileColor: Colors.purple,
                    onTap: () => setState(() =>
                        _categoryTapped(categoryName: categories[index]))),
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(22, 1, 32, 1),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: RefreshIndicator(
          onRefresh: loadCategories,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoriesWidgets.length,
              itemBuilder: (context, index) => categoriesWidgets[index]),
        )
        /* Column(children: categoriesWidgets)*/
        );
  }
}

class medicneAddToCart extends StatefulWidget {
  final Medicine medicine;

  medicneAddToCart({required this.medicine});

  @override
  State<StatefulWidget> createState() {
    return _medicneAddToCartState(medicine: medicine);
  }
}

class _medicneAddToCartState extends State<medicneAddToCart> {
  _medicneAddToCartState({required this.medicine});

  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    return const Text('null');
  }
}
