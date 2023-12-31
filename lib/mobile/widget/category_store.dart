import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/mobile/widget/medicine_page.dart';

class CategoryStore extends StatefulWidget {
  const CategoryStore({super.key, required this.category});

  final String category;

  @override
  State<StatefulWidget> createState() =>
      _CategoryStoreState(category: category);
}

class _CategoryStoreState extends State<CategoryStore> {
  String category;
  late List<Widget> categoryWidgets;
  late List<Medicine> medicines;

  _CategoryStoreState({required this.category});

  late final Widget emptyPage;

  @override
  void initState() {
    super.initState();
    emptyPage = const Center(
      child: CircularProgressIndicator(),
    );

    categoryWidgets = [emptyPage];
    _refresh();
  }

  void _medicinetapped() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MedicinePage(medicine: choosedMedicine),
    ));
  }

  void loadMedicines() async {
    medicines =
        await ImportantLists.loadCategoryMedicines(category, Mode.Mobile);
    loadWidgets();
  }

  late Medicine choosedMedicine;

  void loadWidgets() => setState(() {
        categoryWidgets = List.generate(
            medicines.length,
            (index) => Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(medicines[index].commercialName),
                    // tileColor: Colors.purple,
                    onTap: () {
                      choosedMedicine = medicines[index];
                      _medicinetapped();
                    },
                  ),
                ));
      });

  void _refresh() async {
    loadMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(22, 1, 32, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(253, 232, 223, 1.0),
          title: const Text('Category Medicines'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _refresh,
          child: const Icon(Icons.refresh),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _refresh();
          },
          child: ListView(
            children: categoryWidgets,
          ),
        ));
  }
}
