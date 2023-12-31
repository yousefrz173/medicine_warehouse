/*
  todo:
   implement
*/
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/shared/connect.dart';

class Cart {
  static int get length {
    return cartQuantities.length;
  }

  static List<int> get cartMedicineIDs =>
      List.generate(cartMedicines.length, (index) => cartMedicines[index].id);

  static List<Medicine> cartMedicines = [];

  static List<int> cartQuantities = [];

  static void order() async {
    Connect.httpOrderMobile(
        medicineIDs: cartMedicineIDs, quantities: cartQuantities);
    reset();
  }

  static void reset() {
    cartMedicines = [];
    cartQuantities = [];
  }

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

  static int getMedicineIndexInCart({required Medicine medicine}) {
    for (int index = 0; index < cartMedicines.length; index++) {
      if (cartMedicines[index].medicineInfoMap == medicine.medicineInfoMap) {
        return index;
      }
    }
    return -1;
  }

    static void addMedicine(
      {required Medicine medicine, required int addedAmount}) {
    if (addedAmount > medicine.availableAmount) {
      throw Exception('There is No Enough Quantity');
    }
    // check if medicine is in cart
    int medicineIndex = getMedicineIndexInCart(medicine: medicine);
    // medicine is not in cart
    if (medicineIndex == -1) {
      cartQuantities.add(addedAmount);
      cartMedicines.add(medicine);
      return;
    }
    // medicine is inside cart
    //check if can add more
    if (medicine.availableAmount >
        (addedAmount + cartQuantities[medicineIndex])) {
      throw Exception('There is No Enough Quantity To Add more');
    }
    cartQuantities[medicineIndex] += addedAmount;
    return;
  }

  static void removeMedicine({required Medicine medicine, int? amount}) {
    int medicineIndex = getMedicineIndexInCart(medicine: medicine);
    if (amount == null) {
      cartQuantities.remove(medicineIndex);
    } else if (amount != 0) {
      cartQuantities[medicineIndex] -= amount;
      if (cartQuantities[medicineIndex] <= 0) {
        cartQuantities.remove(medicineIndex);
      }
    }
  }

  static double get cartTotalPrice {
    double price = 0;
    int length = cartQuantities.length;
    for (int index = 0; index <= length; ++index) {
      price += (cartMedicines[index].price * cartQuantities[index]);
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
    var price = orderjson["price"];

    double convertedDoubleValue = orderjson['price'] is int
        ? (orderjson['price'] as int).toDouble()
        : orderjson['price'];

    return Order(
        price: convertedDoubleValue,
        payed: orderjson["payed"],
        state: orderjson["state"]);
  }
}
