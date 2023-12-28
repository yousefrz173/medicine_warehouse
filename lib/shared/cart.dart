/*
  todo:
   implement
*/
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/shared/medicineList.dart';
import 'package:PharmacyApp/shared/connect.dart';

class Cart {
  List<int> get cartMedicineIDs => _quantities.keys.toList();

  List<int> get cartMedicineQuantities => _quantities.values.toList();

  void order() async {
    Connect.httpOrderMobile(
        medicineIDs: cartMedicineIDs, quantities: cartMedicineQuantities);
    _quantities = {};
  }

  void syncPharmacistOrders() async {
    _loadedOrders = [];
    final Map<String, dynamic> rBody = await Connect.httpGetOrdersMobile();
    List<Map<String, dynamic>> orders = rBody["orders"]!;
    for (final orderJson in orders) {
      _loadedOrders.add(Order.fromJson(orderjson: orderJson));
    }
  }

  bool isEmpty() => _quantities.isEmpty;

  void addMedicine({required int medicineId, required int amount}) {
    if (loadedMedicines[medicineId]!.availableAmount <
        (amount + _quantities[medicineId]!)) {
      throw Exception('There is No Enough Quantity');
    }
    if (_quantities[medicineId] == null) {
      _quantities[medicineId] = amount;
    } else {
      _quantities[medicineId] = amount + _quantities[medicineId]!;
    }
    return;
  }

  void removeMedicine({required int medicineId, int? amount}) {
    if (amount == null) {
      _quantities.remove(medicineId);
    } else if (amount != 0) {
      _quantities[medicineId] = _quantities[medicineId]! - amount;
      if (_quantities[medicineId] == 0) {
        _quantities.remove(_quantities[medicineId]);
      }
    }
  }

  List<Order> _loadedOrders = [];

  Map<int, int> _quantities = {};
List<int> MedicineIDs = [];
List<int> quantities = [];

  double get cartTotoalPrice {
    double price = 0;
    for (final entry in _quantities.entries) {
      final Medicine medicine = loadedMedicines[entry.key]!;
      final double medicinePrice = medicine.price;
      price += medicinePrice * entry.value;
    }
    return price;
  }
}

class Order {
  String state;
  String payed;
  double price;

  Order({required this.price, required this.payed, required this.state});

  factory Order.fromJson({required Map<String, dynamic> orderjson}) {
    return Order(
        price: orderjson['price'],
        payed: orderjson['payed'],
        state: orderjson['state']);
  }
}
