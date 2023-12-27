import 'package:PharmacyApp/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'package:PharmacyApp/mobile/current_user.dart';
import 'dart:convert';

class Connect {
  static final Uri _login_url_mobile =
      Uri.parse('http://$BackendRoutMobile:8000/api/login');
  static final Uri _PharmacistRegister_url_mobile =
      Uri.parse('http://$BackendRoutMobile:8000/api/register');
  static final Uri _PharmacistLogout_url_mobile =
      Uri.parse('http://$BackendRoutMobile:8000/api/logout');
  static final Uri _getAllMedicines_url_mobile =
      Uri.parse('http://$BackendRoutMobile:8000/api/getmedicine');
  static final Uri _search_url_mobile =
      Uri.parse('http://$BackendRoutMobile:8000/api/search');

  static Uri _showDetails_url_mobile({required int Medicine_ID}) =>
      Uri.parse('http://$BackendRoutMobile:8000/api//showdetails/$Medicine_ID');
  static final Uri _Order_Medicines_url_mobile =
      Uri.parse('http://$BackendRoutMobile:8000/api/order');

  static Uri get _get_Medicine_Orders_url_mobile => Uri.parse(
      'http://$BackendRoutMobile:8000/api/getorders/${userInfo["id"]}');
  static final Uri _add_to_favorite =
      Uri.parse('http://$BackendRoutMobile:8000/api/add-to-favorite');

  static Future<Map<String, dynamic>> http_login_mobile(
      {required String phone, required String password}) async {
    final response = await http.post(_login_url_mobile,
        body: jsonEncode({
          'phone': phone,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode >= 200 && response.statusCode < 300)
      return jsonDecode(response.body);
    else
      throw Exception(
          'Error: ${response.statusCode}, ${response.reasonPhrase}');
  }

  static Future<Map<String, dynamic>> http_register_mobile(
      {required String phone, required String password}) async {
    final response = await http.post(
      _PharmacistRegister_url_mobile,
      body: jsonEncode({
        'phone': phone,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 300)
      return jsonDecode(response.body);
    else
      throw Exception(
          'Error: ${response.statusCode}, ${response.reasonPhrase}');
  }

  static Future<http.Response> http_logout_mobile() async {
    final response = await http.post(
      _PharmacistLogout_url_mobile,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userInfo["api_token"]}"
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 300)
      return response;
    else
      throw Exception(
          'Error: ${response.statusCode}, ${response.reasonPhrase}');
  }

  static Future<http.Response> http_getAllMedicines_mobile() async {
    final response = await http.get(_getAllMedicines_url_mobile, headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${userInfo["api_token"]}"
    });
    if (response.statusCode >= 200 && response.statusCode < 300)
      return response;
    else
      throw Exception(
          'Error: ${response.statusCode}, ${response.reasonPhrase}');
  }

//todo: implement this
  static Future<http.Response> http_showDetails_mobile(
      {required int Medicine_ID}) async {
    final response = await http
        .get(_showDetails_url_mobile(Medicine_ID: Medicine_ID), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${userInfo["api_token"]}"
    });
    if (response.statusCode >= 200 && response.statusCode < 300)
      return response;
    else
      throw Exception(
          'Error: ${response.statusCode}, ${response.reasonPhrase}');
  }

  static Future<http.Response> http_getOrders_mobile(
      {required List<String> Medicine_IDs,
      required List<String> Medicine_Quantities}) async {
    final response = await http.post(_get_Medicine_Orders_url_mobile, headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${userInfo["api_token"]}"
    }, body: {
      "pharmacist_id": userInfo["id"],
      "medicine_Ids": Medicine_IDs,
      "quan": Medicine_Quantities
    });
    if (response.statusCode >= 200 && response.statusCode < 300)
      return response;
    else
      throw Exception(
          'Error: ${response.statusCode}, ${response.reasonPhrase}');
  }

  static Future<http.Response> http_add_to_favorite_mobile(
      {required int Medicine_ID}) async {
    final response = await http.post(_add_to_favorite, headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${userInfo["api_token"]}"
    }, body: {
      "pharId": userInfo["id"],
      "medId": Medicine_ID
    });
    if (response.statusCode >= 200 && response.statusCode < 300)
      return response;
    else
      throw Exception(
          'Error: ${response.statusCode}, ${response.reasonPhrase}');
  }
}
