import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/shared/connect.dart';
class ImportantLists{
  static List<Medicine> loadedMedicines =[];
  static Map<String, List<Medicine>> loadedMedicinesByCategory = {};

  static List<int> get loadedMedicinesIDs {
    final List<int> result = List.filled(loadedMedicines.length, 0);
    for (int index = 0; index < loadedMedicines.length; ++index) {
      result[index] = loadedMedicines[index].id;
    }
    return result;
  }

  static void loadMedicinesFromServer() async {
    loadedMedicines = [];
    final Map<String, dynamic> jsonData =
    await Connect.httpGetAllMedicinesMobile();
    final Map<String, dynamic> categories = jsonData["categories"];
    for (final String categoryName in categories.keys) {
      loadedMedicinesByCategory[categoryName] = [];
      final List categoryMedicines = categories[categoryName]!;
      for (final Map<String, dynamic> MedicineInfo in categoryMedicines) {
        final Medicine medicine = Medicine.fromJson(MedicineInfo);
        loadedMedicines.add(medicine);
        loadedMedicinesByCategory[categoryName]!.add(medicine);
      }
    }
    for (Medicine medicine in loadedMedicines)
      print(medicine.medicineInfoMap.toString());
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

  static List<Medicine> RecentList = [

  ];


}
