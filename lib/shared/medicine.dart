import 'package:PharmacyApp/shared/cart.dart';
import 'package:PharmacyApp/shared/connect.dart';

enum Mode { Mobile, Web }

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

  Future<void> syncMedicineInformation() async => updateInformationFromMedicine(
      medicine: Medicine.fromJson(
          await Connect.getMedicineInformationMobile(medicineID: id)));

  void updateInformationFromMedicine({required Medicine medicine}) {
    id = medicine.id;
    scientificName = medicine.scientificName;
    commercialName = medicine.commercialName;
    category = medicine.category;
    company = medicine.company;
    expirationDate = medicine.expirationDate;
    price = medicine.price;
    availableAmount = medicine.availableAmount;
  }

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

class OrderedMedicine extends Medicine {
  int orderedAmount;

  OrderedMedicine(
      {required super.id,
      required super.scientificName,
      required super.commercialName,
      required super.category,
      required super.company,
      required super.expirationDate,
      required super.price,
      required super.availableAmount,
      required this.orderedAmount});

  void checkForAmountOverFlow() {
    if (availableAmount < orderedAmount) availableAmount = orderedAmount;
  }

  double get totalPrice => (price * orderedAmount);

  factory OrderedMedicine.fromMedicine(
      {required Medicine medicine, required int orderedAmount}) {
    return OrderedMedicine(
        id: medicine.id,
        scientificName: medicine.scientificName,
        commercialName: medicine.commercialName,
        category: medicine.category,
        company: medicine.company,
        expirationDate: medicine.expirationDate,
        price: medicine.price,
        availableAmount: medicine.availableAmount,
        orderedAmount: orderedAmount);
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

  static Future<List<String>> loadCategories(Mode mode) async {
    final Map<String, dynamic> jsonData = mode == Mode.Mobile
        ? await Connect.httpGetAllMedicinesMobile()
        : await Connect.httpGetAllMedicinesWeb();
    final Map<String, dynamic> categories = jsonData["categories"];
    final List<String> loaded = [];
    for (final String categoryName in categories.keys) {
      loaded.add(categoryName);
    }
    return loaded;
  }

  static Future<List<Medicine>> loadCategoryMedicines(
      String categoryName, Mode mode) async {
    List<Medicine> loaded = [];
    final Map<String, dynamic> jsonData = mode == Mode.Mobile
        ? await Connect.httpGetAllMedicinesMobile()
        : await Connect.httpGetAllMedicinesWeb();
    final Map<String, dynamic> categories = jsonData["categories"];
    final List categoryMedicines = categories[categoryName]!;
    for (final Map<String, dynamic> MedicineInfo in categoryMedicines) {
      loaded.add(Medicine.fromJson(MedicineInfo));
    }
    return loaded;
  }

  static Future<List<Order>> loadOrders(Mode mode) async {
    final Map<String, dynamic> jsonData = mode == Mode.Mobile
        ? await Connect.httpGetOrdersMobile()
        : await Connect.getOrdersAdmin();
    if (jsonData["statusNumber"] == 400) {
      return [];
    }
    final List<dynamic> orders = jsonData["orders"];
    final List<Order> loaded = [];
    for (final Map<String, dynamic> order in orders) {
      var price = order["price"];
      double priceDouble;
      if (price is int)
        priceDouble = price.toDouble();
      else
        priceDouble = price;

      loaded.add(Order(
          price: priceDouble,
          payed: order["payed"],
          state: order["state"],
          // todo: fix this
          id: order["id"]));
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
