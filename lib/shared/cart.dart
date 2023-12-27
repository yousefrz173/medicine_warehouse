/*
  todo:
   implement
*/
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/shared/medicineList.dart';
import 'package:PharmacyApp/shared/connect.dart';

class Cart {
  Cart() {
    _cartMedicines = [];
    _quantities = [];
    _length = 0;
  }

  List<int> get _medicineIDs =>
      List<int>.generate(_length, (index) => _cartMedicines[index].id);


  void _remove_Item({required Medicine medicine, int? amount}) {}

  void Order() async{
    Map <String, dynamic> RBody = await
    Connect.httpOrderMobile(
        Medicine_IDs: _medicineIDs, Quantities: _quantities);
    if(RBody[""])
  }

  void isEmpty() {}

  void addMedicine({required Medicine medicine, required int amount}) {
    if (medicine.amount < amount) {
      throw Exception('There is No Enough Quantity');
    }
    for (int i = 0; i <= _length; i++) {
      if (_cartMedicines[i].medicineInfoMap == medicine.medicineInfoMap) {
        if (_cartMedicines[i].amount < (amount + _quantities[i])) {
          throw Exception('There is No Enough Quantity');
        }
        _quantities[i] += amount;
        return;
      }
    }
    _cartMedicines.add(medicine);
    _quantities.add(amount);
  }

  void removeMedicine({required Medicine medicine, int? amount}) {
    for (int i = 0; i <= _length; i++) {
      if (_cartMedicines[i].medicineInfoMap == medicine.medicineInfoMap) {
        if (amount == null) {
          _cartMedicines.removeAt(i);
          _quantities.removeAt(i);
          return;
        } else {
          _quantities[i] -= amount;
          if (_quantities[i] < 0) {
            _cartMedicines.removeAt(i);
            _quantities.removeAt(i);
          }
          return;
        }
      }
    }
  }

  late int _length;
  late List<Medicine> _cartMedicines;
  late List<int> _quantities;
}}