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
    medicines = await ImportantLists.loadCategoryMedicines(category);
    loadWidgets();
  }

  late Medicine choosedMedicine;

  void loadWidgets() => setState(() {
    categoryWidgets = List.generate(
        medicines.length,
            (index) => SizedBox(
          child: ListTile(
            title: Text(medicines[index].commercialName),
            // tileColor: Colors.purple,
            onTap: () {
              choosedMedicine = medicines[index];
              _medicinetapped();
            },
          ),
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
        body: Card(
          child: ListView(
            children: categoryWidgets,
          ),
        ));
  }
}
