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

  void _categoryTapped({required String categoryName}) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => categoryStore(category: categoryName)),
    );
  }

  void loadCategories() async {
    categories = await ImportantLists.loadCategories();
    setState(() {
      categoriesWidgets = List.generate(
          categories.length,
          (index) => ListTile(
              title: Text(categories[index]),
              tileColor: Colors.purple,
              onTap: () => setState(
                  () => _categoryTapped(categoryName: categories[index]))));
    });
  }

  void _medicinetapped(Medicine medicine) {}

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

class categoryStore extends StatefulWidget {
  categoryStore({super.key, required this.category});
  final String category;
  @override
  State<StatefulWidget> createState() =>
      _categoryStoreState(category: category);
}

class _categoryStoreState extends State<categoryStore> {
  String category;
  late List<Widget> categoryWidgets;
  late List<Medicine> medicines;

  _categoryStoreState({required this.category});

  late final Widget emptyPage;

  @override
  void initState() {
    super.initState();
    emptyPage = const Text('');
    categoryWidgets = [emptyPage];
    _refresh();
  }

  void _medicineTapped(Medicine medicine) {}

  void loadMedicines() async {
    medicines = await ImportantLists.loadCategoryMedicines(this.category);
    loadWidgets();

  }

  void loadWidgets() => setState(() {
        categoryWidgets = List.generate(
            medicines.length,
            (index) => ListTile(
                  title: Text(medicines[index].commercialName),
                  tileColor: Colors.purple,
                  onTap: () => _medicineTapped(medicines[index]),
                ));
      });

  void _refresh() {
    loadMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _refresh,
          child: const Icon(Icons.refresh),
        ),
        body: Column(
          children: categoryWidgets,
        ));
  }
}
