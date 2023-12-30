import 'package:PharmacyApp/shared/medicineList.dart';
import 'package:flutter/material.dart';

Widget screen() {
  var x = Center(
      child: SizedBox(
    width: 700,
    height: 1000,
    child: Center(
      child: Column(
        children: [
          SizedBox(
            width: 1100,
            child: Stack(
              children: [
                Container(
                  width: 900,
                  height: 220,
                  color: Color.fromRGBO(255, 243, 224, 1),
                  child: Image.asset('assets/images/image_processing.gif',
                      fit: BoxFit.contain),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 180),
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(width: 100),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => {},
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.pending,
                                color: Colors.white,
                                size: 55,
                              ),
                              Text(
                                'Orders',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => {},
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.local_shipping,
                                color: Colors.white,
                                size: 40,
                              ),
                              Text(
                                'New \n Order',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(right: 240),
            padding: const EdgeInsets.only(top: 8),
            width: 150,
            height: 30,
            child: const Text(
              'Recent',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: 380,
              height: 400,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: RecentList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.only(top: 13),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.purple,
                          Colors.deepOrangeAccent,
                        ]),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 25,
                      width: 10,
                      child: Text(
                        RecentList[index].commercialName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 60,
                  mainAxisSpacing: 45,
                  childAspectRatio: 3.0,
                  crossAxisSpacing: 35,
                ),
              )),
          SizedBox(
            width: 500,
            height: 3,
          ),
        ],
      ),
    ),
  ));
  return x;
}
