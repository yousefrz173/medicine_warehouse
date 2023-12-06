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

  @override
  build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(22, 1, 32, 1),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) { return <Widget>[

          ]; },
          body: Container(
            width: 600,
            height: 200,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  width: 550,
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (text) {
                            print('submitted');
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search_sharp,
                              color: Colors.white,
                            ),
                            hintText: 'Enter medicine',
                            hintStyle: TextStyle(color: Colors.white54),
                            labelText: 'Search',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: Colors.white),
                            filled: true,
                            fillColor: Color.fromRGBO(255, 255, 255, 0.1),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        width: 400,
                        height: 55,
                      ),
                      Container(
                        height: 40,
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
                                (String value) =>
                                DropdownMenuItem<String>(
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
                    height: 468,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: PharamacistMedicineList.length,
                      itemBuilder: (context, index) {
                        final currentItem = PharamacistMedicineList[index]
                            .commercialName;
                        return ListTile(
                          title: Text(currentItem),
                          tileColor: Colors.purple,
                        );
                      },
                    ),
                )
              ],
            ),
          ),
        ));
  }
}
