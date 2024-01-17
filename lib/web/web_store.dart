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
  final Widget _emptyPage = const Center(
    child: CircularProgressIndicator(),
  );

  void EmptyTheWidget() {
    setState(() {
      categoriesWidgets = [
        _emptyPage,
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    EmptyTheWidget();
    loadCategories();
  }

  void _categoryTapped({required String categoryName}) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => categoryStore(category: categoryName)),
    );
  }

  Future<void> loadCategories() async {
    EmptyTheWidget();
    categories = await ImportantLists.loadCategories(Mode.Web);
    setState(() {
      categoriesWidgets = List.generate(
          categories.length,
          (index) => Card(
                color: Colors.purple,
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: InkWell(
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () => setState(() =>
                        _categoryTapped(categoryName: categories[index]))),
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      floatingActionButton: FloatingActionButton(
        onPressed: loadCategories,
        child: const Icon(Icons.refresh),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        itemCount: categoriesWidgets.length,
        itemBuilder: (context, index) {
          final item = categoriesWidgets[index];
          return item;
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          mainAxisExtent: 160,
          mainAxisSpacing: 45,
          childAspectRatio: 1.0,
          crossAxisSpacing: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
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

  late final Widget emptyPage = const Center(
    child: CircularProgressIndicator(),
  );

  void emptyTheWidget(){
    setState(() {
      categoryWidgets = [emptyPage];
    });
  }
  @override
  void initState() {
    super.initState();
    emptyTheWidget();
    _refresh();
  }

  void _medicinetapped() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MedicinePage(medicine: choosedMedicine),
    ));
  }

  void loadMedicines() async {
    medicines =
        await ImportantLists.loadCategoryMedicines(this.category, Mode.Web);
    loadWidgets();
  }

  late Medicine choosedMedicine;

  void loadWidgets() => setState(() {
        categoryWidgets = List.generate(
            medicines.length,
            (index) => Card(
                  color: Colors.purple,
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: InkWell(
                    child: Center(child: Text(medicines[index].commercialName)),
                    onTap: () {
                      choosedMedicine = medicines[index];
                      _medicinetapped();
                    },
                  ),
                ));
      });

  Future<void> _refresh() async {
    emptyTheWidget();
    loadMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(253, 232, 223, 1.0),
        title: Text('Category Medicines'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        child: const Icon(Icons.refresh),
      ),
      body:  GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            mainAxisExtent: 160,
            mainAxisSpacing: 45,
            childAspectRatio: 1.0,
            crossAxisSpacing: 35,
          ),
          children: categoryWidgets,
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

    );
  }
}

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key, required this.medicine});

  final Medicine medicine;

  @override
  State<StatefulWidget> createState() {
    return _MedicinePageState(medicine: medicine);
  }
}

class _MedicinePageState extends State<MedicinePage> {
  _MedicinePageState({required this.medicine});

  final Medicine medicine;

  Widget FormattedRow({required String title, required String value}) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
          tileColor: Colors.purple,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          title: Row(
            children: [Text(title), Spacer(), Text(value)],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(22, 1, 32, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(253, 232, 223, 1.0),
          title: Text('Medicine Info'),
        ),
        body: ListView(
          children: [
            FormattedRow(
                title: 'commercial name', value: medicine.commercialName),
            FormattedRow(
                title: 'scientific name', value: medicine.scientificName),
            FormattedRow(title: 'company', value: medicine.company),
            FormattedRow(title: 'category', value: medicine.category),
            FormattedRow(
                title: 'price ', value: medicine.price.toStringAsFixed(2)),
            FormattedRow(
                title: 'available amount',
                value: medicine.availableAmount.toString()),
          ],
        ));
  }
}
