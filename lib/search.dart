import 'dart:convert';

import 'package:flutter/material.dart';
import 'home.dart' as HomePage;
import 'medicine.dart';
import 'medicineList.dart';
import 'package:http/http.dart' as http;
import 'current_user.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  static final String route = '/route_search';

  @override
  State<Search> createState() => _SearchState();
}

enum Filter { searchBy, Name, Genre }

class _SearchState extends State<Search> {
  String? _selectedSearchType = 'search by';
  bool _isLoading = false;
  int itemCount = 0;
  TextEditingController _searchController = TextEditingController(text: '');
  List<Medicine> allItems = [];

  List<Medicine> _searchResults = [];
  Filter? filter = Filter.searchBy;

  void search(String query) {
    _searchResults.clear();
    for (Medicine item in allItems) {
      if (item.scientificName.contains(query)) {
        _searchResults.add(item);
      }
    }
    setState(() {}); // Trigger a rebuild to update the UI with search results
  }

  void sortBy(Filter? filter, List<Medicine> sortedList) {
    if (filter == Filter.searchBy) {
      return;
    }
    List<Medicine> sortedList = PharamacistMedicineList;
    if (filter == Filter.Genre) {
      setState(() {
        sortedList.sort((a, b) => a.genre.compareTo(b.genre));
      });
    } else if (filter == Filter.Name) {
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
                  _getMedicines();
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
            height: 600,
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
                                sortBy(Filter.Name, _searchResults);
                              else if (newValue == 'Genre')
                                sortBy(Filter.Genre, _searchResults);
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
                  height: 260,
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
                                setState(() {
                                  RecentList.add(currentItem);
                                });
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            Color.fromRGBO(153, 153, 153, 1.0),
                                        title: Row(
                                          children: [
                                            Text('Medicine Info'),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(Icons.close)),
                                          ],
                                        ),
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
                                            Text(DateFormat('yy/MM/dd').format(currentItem.expirationDate)
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
                      : _isLoading
                          ? CircularProgressIndicator()
                          : Center(
                              child: Text(
                                'No Results',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                )
              ],
            ),
          ),
        ));
  }

  _getMedicines() async {
    _switchLoading(true);
    http.Response response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/getmedicine'),
      headers: {
        'Authorization': "Bearer ${userInfo["api_token"]}"
      }
    );
    _switchLoading(false);
    if (jsonDecode(response.body)["statusNumber"] == 200) {
      setState(() {
        Map<String, dynamic> responseMap =
            jsonDecode(response.body)["categories"];
        for (var key in responseMap.keys) {
          allItems.add(Medicine(
              id: responseMap[key][0]["id"],
              scientificName: responseMap[key]![0]["s_name"],
              commercialName: responseMap[key]![0]["s_name"],
              genre: key,
              company: responseMap[key]![0]["s_name"],
              expirationDate: responseMap[key]![0]["id"],
              price: responseMap[key]![0]["price"],
              amount: responseMap[key]![0]["id"]));
        }
      });
      print(jsonDecode(response.body)["message"]);
    } else if (jsonDecode(response.body)["statusNumber"] == 403) {
      print(jsonDecode(response.body)["message"]);
    }
  }
}
