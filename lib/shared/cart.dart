/*
  todo:
   implement
*/
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/shared/connect.dart';

class Cart {
  static int get length {
    return medicinesMap.length;
  }

  static List<int> get _cartMedicineIDs {
    List<int> result = [];
    if (!medicinesMap.isEmpty) {
      for (var medicine in medicinesMap.values) {
        result.add(medicine.id);
      }
    }
    return result;
  }

  static List<int> get cartQuantities {
    List<int> result = [];
    if (!medicinesMap.isEmpty) {
      for (var medicine in medicinesMap.values) {
        result.add(medicine.orderedAmount);
      }
    }
    return result;
  }

  static Map<int, OrderedMedicine> medicinesMap = {};

  static List<OrderedMedicine> get medicinesList =>
      medicinesMap.values.toList();

  static void order() async {
    try {
      Connect.orderMobile(
          medicineIDs: _cartMedicineIDs, quantities: cartQuantities);
      resetCart();
    } catch (e) {
      print(e.toString());
    }
  }

  static void resetCart() {
    medicinesMap = {};
  }

  /*
   static Future<List<Order>?> loadOrders() async {
     List<Order> loadedOrders = [];
     final Map<String, dynamic> rBody = await Connect.httpGetOrdersMobile();
     List<dynamic> orders = rBody["orders"]!;
     if (orders.isEmpty) {
       return null;
     }
     // List<Map<String, dynamic>> orders = x;
     for (final Map<String, dynamic> orderJson in orders) {
       loadedOrders.add(Order.fromJson(orderjson: orderJson));
     }
     return loadedOrders;
   }
   */

  static bool addMedicine({required Medicine medicine, required int amount}) {
    if (amount > medicine.availableAmount) {
      return false;
    }
    // check if medicine is in cart
    if (medicinesMap[medicine.id] == null) {
      medicinesMap[medicine.id] = OrderedMedicine.fromMedicine(
          medicine: medicine, orderedAmount: amount);

      return true;
    }

    final int TotalAddedAmount =
        amount + medicinesMap[medicine.id]!.orderedAmount;
    if (TotalAddedAmount > medicine.availableAmount) return false;

    medicinesMap[medicine.id]!.orderedAmount = TotalAddedAmount;
    return true;
  }

  static void removeMedicine({required Medicine medicine, int? amount}) {
    if (amount == null) {
      Cart.medicinesMap.remove(medicine.id);
      return;
    }
    if (amount == 0) {
      medicinesMap.remove(medicine.id);
      return;
    }
    if (medicinesMap[medicine.id]!.orderedAmount == 0) {
      medicinesMap.remove(medicine.id);
      return;
    }
    int updatedOrderedAmount =
        Cart.medicinesMap[medicine.id]!.orderedAmount - amount;
    if (updatedOrderedAmount < 0) {
      Cart.medicinesMap.remove(medicine.id);
      return;
    }
    Cart.medicinesMap[medicine.id]!.orderedAmount = updatedOrderedAmount;
  }

  static double get cartTotalPrice {
    double price = 0;

    for (OrderedMedicine orderedMedicine in Cart.medicinesMap.values) {
      price += (orderedMedicine.totalPrice);
    }
    return price;
  }
}

class Order {
  int id;
  String state;
  String payed;
  double price;

  Order(
      {required this.price,
        required this.payed,
        required this.state,
        required this.id});

  factory Order.fromJson({required Map<String, dynamic> orderjson}) {
    dynamic price = orderjson["price"];
    double convertedDoubleValue = price is int ? price.toDouble() : price;
    return Order(
        id: 0,
        price: convertedDoubleValue,
        payed: orderjson["payed"],
        state: orderjson["state"]);
  }
}
