/*
  todo:
   implement
*/
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/shared/medicineList.dart';

class Cart {
  Cart() {
    cartMedicines = [];
    quantities = [];
    length = 0;
  }

  void addMedicine(
      {required Medicine addedMedicine, required int addedQuantity}) {
    for (int i = 0; i <= length; i++) {
      if (cartMedicines[i] == addedMedicine) {
        quantities[i] += addedQuantity;
        return;
      }
    }
    cartMedicines.add(addedMedicine);
    quantities.add(addedQuantity);
  }

  late int length;
  late List<Medicine> cartMedicines;
  late List<int> quantities;
}
