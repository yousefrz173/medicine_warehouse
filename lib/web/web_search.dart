/*
todo:
   design
   connect
   based on mobile
*/
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:PharmacyApp/web/web_home.dart' as HomePage;
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:http/http.dart' as http;
import 'package:PharmacyApp/shared/connect.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  static final String route = '/route_search';

  @override
  State<Search> createState() => _SearchState();
}

enum Filter { searchBy, Name, Genre }

class _SearchState extends State<Search> {
  GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey();
  String? _selectedSearchType = 'search by';
  bool _isLoading = false;
  int itemCount = 0;
  TextEditingController _searchController = TextEditingController(text: '');
  List<Medicine> allItems = [];
  List<Medicine> _tempList = [];

  List<Medicine> _searchResults = [];
  Filter? filter = Filter.searchBy;

  Timer t = Timer(Duration(seconds: 10), () async {
    http.Response response = await http.get(Uri.parse('url'));
  });

  void search(String query, Filter filter) {
    ScaffoldKey.currentState!.setState(() {
      _searchResults.clear();
      for (Medicine item in allItems) {
        if (filter == Filter.searchBy) {
          _searchResults.add(item);
        } else if (filter == Filter.Genre) {
          if (item.category.contains(query)) {
            _searchResults.add(item);
          }
        } else if (filter == Filter.Name) {
          if (item.scientificName.contains(query)) {
            _searchResults.add(item);
          }
        }
      }
    });
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
        key: ScaffoldKey,
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
                  search(_searchController.text, filter!);
                },
              ),
            ),
            onChanged: (value) {
              //search(value, filter!);
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
                                  Text(currentItem.category),
                                ],
                              ),
                              tileColor: Colors.purple,
                              onTap: () {
                                setState(() {
                                  ImportantLists.RecentList.add(currentItem);
                                });
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            Color.fromRGBO(153, 153, 153, 1.0),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                            Text(
                                                'Scientefic Name : ${currentItem.scientificName}'),
                                            Text(
                                                'Commercial Name : ${currentItem.commercialName}'),
                                            Text(
                                                'Category : ${currentItem.category}'),
                                            Text(
                                                'Company : ${currentItem.company}'),
                                            Text(
                                                'Amount : ${'currentItem.amount'}'),
                                            Text(
                                                'Price : ${currentItem.price}'),
                                            Text(
                                                'Expiration Date : ${DateFormat('dd/MM/yyyy').format(currentItem.expirationDate).toString()}'),
                                          ],
                                        ),
                                      );
                                    });
                              },
                            );
                          },
                        )
                      : _isLoading
                          ? SizedBox(
                              width: 40,
                              height: 10,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2.0),
                            )
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
    try {
      _switchLoading(true);

      var rBody = await Connect.httpGetAllMedicinesWeb();
      _switchLoading(false);
      setState(() {
        Map<String, dynamic> responseMap = rBody["categories"];
        _tempList.clear();

        for (var key in responseMap.keys) {
          _tempList.add(Medicine(
              id: responseMap[key][0]["id"],
              scientificName: responseMap[key]![0]["s_name"],
              commercialName: responseMap[key]![0]["t_name"],
              category: responseMap[key]![0]["category"],
              company: responseMap[key]![0]["s_name"],
              expirationDate: DateTime.parse(responseMap[key]![0]["end_date"]),
              price: responseMap[key]![0]["price"] is double
                  ? responseMap[key]![0]["price"]
                  : double.parse('${responseMap[key]![0]["price"]}.0'),
              availableAmount: responseMap[key]![0]["id"]));
        }
        _tempList.sort((a, b) => a.scientificName.compareTo(b.scientificName));
        allItems = _tempList;
      });
      print(rBody["message"]);
    } catch (e) {
      print(e.toString());
    }
  }
}
