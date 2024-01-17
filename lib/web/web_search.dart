import 'package:PharmacyApp/shared/connect.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/mobile/category_store.dart';
import 'package:PharmacyApp/mobile/medicine_page.dart';

class Search extends StatefulWidget {
  static const String route = '/route_search';

  @override
  State<Search> createState() => _SearchState();
}

enum Filter { Name, Genre }

class _SearchState extends State<Search> {
  bool _isLoading = false;
  String? _selectedSearchType = 'search by';
  int itemCount = 0;
  final TextEditingController _searchController =
      TextEditingController(text: '');

  late Widget? _searchResults = null;

  Filter? filter = Filter.Name;
  final Widget _emptyPage = Center(
    child: CircularProgressIndicator(),
  );

  void EmptyTheWidget() {
    setState(() {
      _searchResults = _emptyPage;
    });
  }

  Future<void> search(String query, Filter filter) async {
    EmptyTheWidget();
    var rBody = await Connect.httpSearchWeb(value: query);
    print(rBody);
    var medicines = rBody["medicine"];
    print(medicines);
    if (rBody["statusNumber"] == 400) {
      setState(() {
        _searchResults = null;
      });
      return;
    }
    for (Map<String, dynamic> medicine in medicines) {}
    if (medicines.length > 1) {
      String category = medicines[0]["category"];
      setState(() {
        _searchResults = Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 3,
          child: ListTile(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              title: Text(category),
              tileColor: Colors.purple,
              onTap: () =>
                  setState(() => _categoryTapped(categoryName: category))),
        );
      });
    } else {
      var medicine = Medicine(
          id: 0,
          scientificName: medicines[0]["s_name"],
          commercialName: medicines[0]["t_name"],
          category: medicines[0]["category"],
          company: medicines[0]["company"],
          expirationDate: DateTime.parse(medicines[0]["end_date"]),
          price: medicines[0]["price"],
          availableAmount: medicines[0]["amount"]);
      setState(() {
        _searchResults = Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 3,
          child: ListTile(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              title: Text(medicines[0]["s_name"]),
              tileColor: Colors.purple,
              onTap: () =>
                  setState(() => _medicineTapped(choosedMedicine: medicine))),
        );
      });
    }
  }

  void _categoryTapped({required String categoryName}) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CategoryStore(
                category: categoryName,
                mode: Mode.Web,
              )),
    );
  }

  void _medicineTapped({required Medicine choosedMedicine}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          MedicinePage(medicine: choosedMedicine, mode: Mode.Web),
    ));
  }

  void sortBy(List<Medicine> sortedList) {
    if (sortedList.isNotEmpty) {
      setState(() {
        sortedList.sort((a, b) => a.scientificName.compareTo(b.scientificName));
      });
    }
  }

  void _switchLoading(bool b) {
    _isLoading = b;
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 1, 32, 1),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              search(_searchController.text, filter!);
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
            },
          ),
        ],
        backgroundColor: Color.fromRGBO(153, 153, 153, 1.0),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            search(value, filter!);
          },
        ),
      ),
      body: Container(
        width: 2500,
        height: 600,
        child: Column(
          children: [
            Container(
              height: 70,
              child: _searchResults != null
                  ? _searchResults
                  : Center(
                      child: Text(
                        'No Results',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
