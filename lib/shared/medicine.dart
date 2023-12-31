import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/shared/connect.dart';

class Medicine {
  String scientificName;
  String commercialName;
  String category;
  String company;
  DateTime expirationDate;
  double price;
  int id;
  int availableAmount;

  Medicine({
    required this.id,
    required this.scientificName,
    required this.commercialName,
    required this.category,
    required this.company,
    required this.expirationDate,
    required this.price,
    required this.availableAmount,
  });

  Map<String, Object> get medicineInfoMap => {
        "id": id,
        "scientificName": scientificName,
        "commercialName": commercialName,
        "category": category,
        "company": company,
        "expirationDate": expirationDate,
        "price": price,
        "availableAmount": availableAmount,
      };

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      scientificName: json['s_name'],
      commercialName: json['t_name'],
      category: json['category'],
      company: json['company'],
      availableAmount: json['amount'],
      expirationDate: DateTime.parse(json['end_date']),
      price: json['price'].toDouble(),
    );
  }
}

class ImportantLists {
  static Future<List<Medicine>> loadAllMedicines() async {
    List<Medicine> loaded = [];
    final Map<String, dynamic> jsonData =
        await Connect.httpGetAllMedicinesMobile();
    final Map<String, dynamic> categories = jsonData["categories"];
    for (final String categoryName in categories.keys) {
      loadedMedicinesByCategory[categoryName] = [];
      final List categoryMedicines = categories[categoryName]!;
      for (final Map<String, dynamic> MedicineInfo in categoryMedicines) {
        final Medicine medicine = Medicine.fromJson(MedicineInfo);
        loaded.add(medicine);
        loadedMedicinesByCategory[categoryName]!.add(medicine);
      }
    }
    return loaded;
  }

  static Future<List<String>> loadCategories() async {
    final Map<String, dynamic> jsonData =
        await Connect.httpGetAllMedicinesMobile();
    final Map<String, dynamic> categories = jsonData["categories"];
    final List<String> loaded = [];
    for (final String categoryName in categories.keys) {
      loaded.add(categoryName);
    }
    return loaded;
  }

  static Future<List<Medicine>> loadCategoryMedicines(
      String categoryName) async {
    List<Medicine> loaded = [];
    final Map<String, dynamic> jsonData =
        await Connect.httpGetAllMedicinesMobile();
    final Map<String, dynamic> categories = jsonData["categories"];
    final List categoryMedicines = categories[categoryName]!;
    for (final Map<String, dynamic> MedicineInfo in categoryMedicines) {
      loaded.add(Medicine.fromJson(MedicineInfo));
    }
    return loaded;
  }

  static List<Medicine> PharamacistMedicineList = List.generate(
      12,
      (index) => Medicine(
          id: 0,
          scientificName: 'a$index',
          commercialName: 'Aspirin',
          category: 'anti-inflammatory',
          company: 'Bayer AG',
          expirationDate: DateTime(2026, 12, 4),
          price: 4.45,
          availableAmount: 100));
  static List<Medicine> StorekeeperMedicineList = List.generate(
    12,
    (index) => Medicine(
        id: 0,
        scientificName: 'acetylsalicylic',
        commercialName: 'Aspirin',
        category: 'anti-inflammatory',
        company: 'Bayer AG',
        expirationDate: DateTime(2026, 12, 4),
        price: 4.45,
        availableAmount: 100),
  );

  static List<Medicine> RecentList = [];
  static Map<String, List<Medicine>> loadedMedicinesByCategory = {};

  static List<int> loadedMedicinesIDs(List<Medicine> loaded) {
    final List<int> result = List.filled(loaded.length, 0);
    for (int index = 0; index < loaded.length; ++index) {
      result[index] = loaded[index].id;
    }
    return result;
  }
}
