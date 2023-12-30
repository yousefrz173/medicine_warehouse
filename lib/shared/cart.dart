/*
  todo:
   implement
*/
import 'package:PharmacyApp/shared/medicine.dart';
import 'package:PharmacyApp/shared/connect.dart';

Cart x = Cart();

class Cart {
  static int get length {
    return quantities.length;
  }



  static List<int> get cartMedicineIDs {
    int length = Medicines.length;
    List<int> result = List.filled(length, 0);
    for (int index = 0; index < length; ++index) {
      result[index] = Medicines[index].id;
    }
    return result;
  }

  static List<Medicine> Medicines = [];
  static List<int> quantities = [];

  static void order() async {
    Connect.httpOrderMobile(
        medicineIDs: cartMedicineIDs, quantities: quantities);
    reset();
  }

  static void reset() {
    Medicines = [];
    quantities = [];
  }

  static void syncPharmacistOrders() async {
    loadedOrders = [];
    final Map<String, dynamic> rBody = await Connect.httpGetOrdersMobile();
    List<Map<String, dynamic>> orders = rBody["orders"]!;
    for (final orderJson in orders) {
      loadedOrders.add(Order.fromJson(orderjson: orderJson));
    }
  }

  static bool isEmpty() => quantities.isEmpty;

  static int getMedicineIndexInCart({required Medicine medicine}) {
    for (int index = 0; index < Medicines.length; index++) {
      if (Medicines[index].medicineInfoMap == medicine.medicineInfoMap) {
        return index;
      }
    }
    return -1;
  }

  static void addMedicine({required Medicine medicine, required int amount}) {
    if (amount > medicine.availableAmount)
      throw Exception('There is No Enough Quantity');
    // check if medicine is in cart
    int medicineIndex = getMedicineIndexInCart(medicine: medicine);
    // medicine is not in cart
    if (medicineIndex == -1) {
      quantities.add(amount);
      Medicines.add(medicine);
      return;
    }
    // medicine is inside cart
    //check if can add more
    if (medicine.availableAmount > (amount + quantities[medicineIndex]))
      throw Exception('There is No Enough Quantity To Add more');
    quantities[medicineIndex] += amount;
    return;
  }

  static void removeMedicine({required Medicine medicine, int? amount}) {
    int medicineIndex = getMedicineIndexInCart(medicine: medicine);

    if (amount == null) {
      quantities.remove(medicineIndex);
    } else if (amount != 0) {
      quantities[medicineIndex] -= amount;
      if (quantities[medicineIndex] <= 0) {
        quantities.remove(medicineIndex);
      }
    }
  }

  static List<Order> loadedOrders = [];
  static List<Order> get Orders => loadedOrders;

  static double get cartTotoalPrice {
    double price = 0;
    int length = quantities.length;
    for (int index = 0; index <= length; ++index) {
      price += (Medicines[index].price * quantities[index]);
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
