import 'package:http/http.dart' as http;
import 'dart:convert';

const String backendRoutMobile = '10.0.2.2';
const String backendRoutWeb = '127.0.0.1';

Map<String, dynamic> userInfo = {
  "id": null,
  "phone": 0,
  "password": r"",
  "api_token": "",
};

class Connect {
  static Map<String, dynamic> _convertToMap({required http.Response response}) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final respondBody = jsonDecode(response.body);
      if (respondBody["statusNumber"] == 200) {
        return respondBody;
      } else {
        throw Exception(respondBody["message"]);
      }
    } else {
      throw Exception(
          'Error: ${response.statusCode}, ${response.reasonPhrase}');
    }
  }

  static get x => {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userInfo["api_token"]}"
      };

  static get userID => userInfo["id"];

  static final _loginUrlMobile =
      Uri.parse('http://$backendRoutMobile:8000/api/login');
  static final _pharmacistRegisterUrlMobile =
      Uri.parse('http://$backendRoutMobile:8000/api/register');
  static final _pharmacistLogoutUrlMobile =
      Uri.parse('http://$backendRoutMobile:8000/api/logout');
  static final _getAllMedicinesUrlMobile =
      Uri.parse('http://$backendRoutMobile:8000/api/getmedicine');

  static Uri _showDetailsUrlMobile({required int Medicine_ID}) =>
      Uri.parse('http://$backendRoutMobile:8000/api//showdetails/$Medicine_ID');
  static final _OrderMedicinesUrlMobile =
      Uri.parse('http://$backendRoutMobile:8000/api/order');

  static Uri get _get_Medicine_Orders_url_mobile =>
      Uri.parse('http://$backendRoutMobile:8000/api/getorders/$userID');
  static final _add_to_favorite =
      Uri.parse('http://$backendRoutMobile:8000/api/add-to-favorite');

  static Future<Map<String, dynamic>> http_login_mobile(
      {required String phone, required String password}) async {
    final response = await http.post(
      _loginUrlMobile,
      body: jsonEncode(
        {
          'phone': phone,
          'password': password,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> httpRegisterMobile(
      {required String phone, required String password}) async {
    final response = await http.post(
      _pharmacistRegisterUrlMobile,
      body: jsonEncode({
        'phone': phone,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> http_logout_mobile() async {
    final response = await http.post(
      _pharmacistLogoutUrlMobile,
      headers: x,
    );
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> http_getAllMedicines_mobile() async {
    final response = await http.get(_getAllMedicinesUrlMobile, headers: x);
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> http_showDetails_mobile(
      {required int medicineID}) async {
    final response = await http
        .get(_showDetailsUrlMobile(Medicine_ID: medicineID), headers: x);
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> http_getOrders_mobile(
      {required List<String> MedicineIDs,
      required List<String> Medicine_Quantities}) async {
    final response =
        await http.post(_get_Medicine_Orders_url_mobile, headers: x, body: {
      "pharmacist_id": userID,
      "medicine_Ids": MedicineIDs,
      "quan": Medicine_Quantities
    });
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> http_add_to_favorite_mobile(
      {required int Medicine_ID}) async {
    final response = await http.post(_add_to_favorite,
        headers: x, body: {"pharId": userID, "medId": Medicine_ID});
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> httpOrderMobile(
      {required List<int> Medicine_IDs, required List<int> Quantities}) async {
    final response = await http.post(_OrderMedicinesUrlMobile,
        headers: x,
        body: {
          "pharmacist_id": userID,
          "medicine_Ids": Medicine_IDs,
          "quan": Quantities
        });
    return _convertToMap(response: response);
  }
}
