import 'package:flutter/material.dart';
import 'home.dart' as HomePage;
import 'medicine.dart';
import 'medicineList.dart';

class Search extends StatefulWidget {
  static final String route = '/route_search';

  @override
  State<Search> createState() => _SearchState();
}

enum Filter { searchBy, Name, Genre }

class _SearchState extends State<Search> {
  String? _selectedSearchType = 'search by';
  int itemCount = 0;
  TextEditingController _searchController = TextEditingController(text: '');
  List<Medicine> allItems = PharamacistMedicineList;
  List<Medicine> _searchResults = [];
  Filter? filter = Filter.searchBy;

  void search(String query) {
    _searchResults.clear();
    for (Medicine item in allItems) {
      if (item.commercialName.contains(query)) {
        _searchResults.add(item);
      }
    }
    setState(() {}); // Trigger a rebuild to update the UI with search results
  }

  void sortBy(Filter? filter) {
    if (filter == Filter.searchBy) {
      return;
    }
    if (filter == Filter.Genre) {
      setState(() {
        PharamacistMedicineList.sort((a, b) => a.genre.compareTo(b.genre));
      });
    } else if (filter == Filter.Name) {
      setState(() {
        PharamacistMedicineList.sort(
            (a, b) => a.scientificName.compareTo(b.scientificName));
      });
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(153, 153, 153, 1.0),
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  search(_searchController.text);
                },
              ),
            ),
            onChanged: (value) {
              // Implement your search logic here
              search(value);
            },
          ),
        ),
        backgroundColor: Color.fromRGBO(22, 1, 32, 1),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[];
          },
          body: Container(
            width: 600,
            height: 400,
            child: Column(
              children: [
                Container(
                  width: 550,
                  height: 40,
                  child: Column(
                    children: [
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(left: 300),
                        child: DropdownButton<String>(
                          dropdownColor: Color.fromRGBO(153, 153, 153, 1),
                          value: _selectedSearchType,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedSearchType = newValue;
                              if (newValue == 'Name')
                                sortBy(Filter.Name);
                              else if (newValue == 'Genre')
                                sortBy(Filter.Genre);
                            });
                          },
                          items: ['search by', 'Name', 'Genre']
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 460,
                  child: _searchResults.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final currentItem = _searchResults[index];
                            return ListTile(
                              style: ListTileStyle.list,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: Row(
                                children: [
                                  Text(currentItem.scientificName),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text(currentItem.genre),
                                ],
                              ),
                              tileColor: Colors.purple,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            Color.fromRGBO(153, 153, 153, 1.0),
                                        title: IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(Icons.close)),
                                        content: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(currentItem.scientificName),
                                            Text(currentItem.commercialName),
                                            Text(currentItem.genre),
                                            Text(currentItem.company),
                                            Text('${currentItem.amount}'),
                                            Text('${currentItem.price}'),
                                            Text(currentItem.expirationDate
                                                .toString()),
                                          ],
                                        ),
                                        actions: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(Icons.close))
                                        ],
                                      );
                                    });
                              },
                            );
                          },
                        )
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
        ));
  }
}
