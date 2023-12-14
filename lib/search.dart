import 'package:flutter/material.dart';
import 'home.dart' as HomePage;
import 'medicineList.dart';

class Search extends StatefulWidget {
  static final String route = '/route_search';

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _selectedSearchType = 'search by';
  int itemCount = 0;
  TextEditingController _searchController = TextEditingController();
  List<String> allItems = ['Apple', 'Banana', 'Orange', 'Mango'];
  List<String> _searchResults = [];

  void search(String query) {
    _searchResults.clear();
    for (String item in allItems) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        _searchResults.add(item);
      }
    }
    setState(() {}); // Trigger a rebuild to update the UI with search results
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
                icon: Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  search('');
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
                              _selectedSearchType = newValue!;
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
                  height: 268,
                  child: _searchResults.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final currentItem = _searchResults[index];
                            return ListTile(
                              style: ListTileStyle.list,
                              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              title: Text(currentItem),
                              tileColor: Colors.purple,
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            'No results',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
