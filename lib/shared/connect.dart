import 'package:http/http.dart' as http;
import 'dart:convert';

const String IP1 = '10.0.2.2';
const String IP2 = '127.0.0.1';
const String usedIP = IP1;

Map<String, dynamic> userInfoPharmacist = {
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

  static get authorizedHeader => {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userInfoPharmacist["api_token"]}"
      };

  static get userID => userInfoPharmacist["id"];

  static final _loginUrlMobile = Uri.parse('http://$IP1:8000/api/login');
  static final _pharmacistRegisterUrlMobile =
      Uri.parse('http://$IP1:8000/api/register');
  static final _pharmacistLogoutUrlMobile =
      Uri.parse('http://$IP1:8000/api/logout');
  static final _getAllMedicinesUrlMobile =
      Uri.parse('http://$IP1:8000/api/getmedicine');

  static final _searchUrlMobile =
      Uri.parse('http://$IP1:8000/api/getmedicine/search?');

  static Uri _showDetailsUrlMobile({required int medicineID}) =>
      Uri.parse('http://$IP1:8000/api//showdetails/$medicineID');
  static final _orderMedicinesUrlMobile =
      Uri.parse('http://$IP1:8000/api/order');

  static Uri get _getMedicineOrdersUrlMobile =>
      Uri.parse('http://$IP1:8000/api/getorders/$userID');
  static final addToFavoriteUrlMobile =
      Uri.parse('http://$IP1:8000/api/add-to-favorite');

  static final _getAllMedicinesUrlWeb =
  Uri.parse('http://$IP2:8000/all-medicine');

  static Future<Map<String, dynamic>> httpLoginMobile(
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

  static Future<Map<String, dynamic>> httpLogoutMobile() async {
    final response = await http.post(
      _pharmacistLogoutUrlMobile,
      headers: authorizedHeader,
    );
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> httpGetAllMedicinesMobile() async {
    final response =
        await http.get(_getAllMedicinesUrlMobile, headers: authorizedHeader);
    return _convertToMap(response: response);
  }
  static Future<Map<String, dynamic>> httpGetAllMedicinesWeb() async {
    final response =
    await http.get(_getAllMedicinesUrlWeb, headers: authorizedHeader);
    return _convertToMap(response: response);
  }
  static Future<Map<String, dynamic>> httpShowDetailsMobile(
      {required int medicineID}) async {
    final response = await http.get(
        _showDetailsUrlMobile(medicineID: medicineID),
        headers: authorizedHeader);
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> httpGetOrdersMobile() async {
    final response =
        await http.get(_getMedicineOrdersUrlMobile, headers: authorizedHeader);
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> httpOrderMobile(
      {required List<int> medicineIDs, required List<int> quantities}) async {
    final response = await http.post(_orderMedicinesUrlMobile,
        headers: authorizedHeader,
        body: {
          "pharmacist_id": userID,
          "medicine_Ids": medicineIDs,
          "quan": quantities
        });
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> httpAddToFavoriteMobile(
      {required int medicineID}) async {
    final response = await http.post(addToFavoriteUrlMobile,
        headers: authorizedHeader,
        body: {"pharId": userID, "medId": medicineID});
    return _convertToMap(response: response);
  }

  static Future<Map<String, dynamic>> httpSearchMobile(
      {required String value}) async {
    final response = await http.post(_searchUrlMobile,
        headers: authorizedHeader, body: {"value": value});
    return _convertToMap(response: response);
  }
}
