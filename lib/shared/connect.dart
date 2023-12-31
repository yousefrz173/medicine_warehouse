import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;
import 'dart:async';

const String usedIpAdmin = '127.0.0.1';
const String usedIPPharmacist = '10.0.2.2';

Map<String, dynamic> userInfo = {
  "id": null,
  "phone": 0,
  "api_token": "",
  // for admin
  "username": "",
  "_token": "",
  "yousef_session": "",
  // for both
  "password": r"",
};

class Connect {
  static Map<String, dynamic> _convertToMapAndGetBody(
      {required http.Response response}) {
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
        'Authorization': "Bearer ${userInfo["api_token"]}"
      };

  static get userID => userInfo["id"];

  static final _loginUrlMobile =
      Uri.parse('http://$usedIPPharmacist:8000/api/login');
  static final _pharmacistRegisterUrlMobile =
      Uri.parse('http://$usedIPPharmacist:8000/api/register');
  static final _pharmacistLogoutUrlMobile =
      Uri.parse('http://$usedIPPharmacist:8000/api/logout');
  static final _getAllMedicinesUrlMobile =
      Uri.parse('http://$usedIPPharmacist:8000/api/getmedicine');

  static final _searchUrlMobile =
      Uri.parse('http://$usedIPPharmacist:8000/api/getmedicine/search?');

  static Uri _showDetailsUrlMobile({required int medicineID}) =>
      Uri.parse('http://$usedIPPharmacist:8000/api//showdetails/$medicineID');
  static final _orderMedicinesUrlMobile =
      Uri.parse('http://$usedIPPharmacist:8000/api/order');

  static Uri get _getMedicineOrdersUrlMobile =>
      Uri.parse('http://$usedIPPharmacist:8000/api/getorders/$userID');
  static final addToFavoriteUrlMobile =
      Uri.parse('http://$usedIPPharmacist:8000/api/add-to-favorite');

  static final _changestateAdmin =
      Uri.parse('http://$usedIpAdmin:8000/changestate');
  static final _addMedicineAdmin =
      Uri.parse('http://$usedIpAdmin:8000/add-medicine');
  static final _logoutAdmin = Uri.parse('http://$usedIpAdmin:8000/logout');

  static final _csrf_tokenAdmin =
      Uri.parse('http://$usedIpAdmin:8000/csrf-token');

  static final _getOrdersAdmin =
      Uri.parse('http://$usedIpAdmin:8000/getorders');

  static _order_datails({required orderNumber}) =>
      Uri.parse('http://$usedIpAdmin:8000/order-datails/$orderNumber');
  static final _getmedicine =
      Uri.parse('http://$usedIpAdmin:8000/api/getmedicine');

  static Future<Map<String, dynamic>> getmedicineAdmin() async {
    final response = await http.get(_getmedicine,
        headers: {'Authorization': "Bearer ${userInfo["api_token"]}"});
    return _convertToMapAndGetBody(response: response);
  }

  static Future<Map<String, dynamic>> orderDetails(
      {required int orderNumber}) async {
    var response =
        await http.get(Connect._order_datails(orderNumber: orderNumber));
    return {};
  }

  static Future<Map<String, dynamic>> getOrdersAdmin() async {
    var response = await http.get(Connect._getOrdersAdmin);
    return _convertToMapAndGetBody(response: response);
  }

  static Future<Map<String, dynamic>> getCsrfToken() async {
    var response = await http.get(Connect._csrf_tokenAdmin);
    return _convertToMapAndGetBody(response: response);
  }

  static Future<Map<String, dynamic>> loginAdmin(
      {required String username, required String password}) async {
    var rBody = await Connect.getCsrfToken();
    var csrfToken = rBody["csrf_token"];
    var sessionID = rBody["yousef_session"];
    var response = await http.post(
      Uri.parse('http://$usedIPPharmacist:8000/login'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        "_token": csrfToken,
        "username": username,
        "password": password,
      },
    );
    userInfo = {
      "_token": csrfToken,
      "username": username,
      "password": password,
      "yousef_session": sessionID,
    };
    return {};
  }

  static Future<Map<String, dynamic>> logoutAdmin() async {
    var response = await http.get(
      _logoutAdmin,
    );
    return _convertToMapAndGetBody(response: response);
  }

  static Future<Map<String, dynamic>> httpAddMedicineAdmin(
      {required price,
      required end_state,
      required amount,
      required company,
      required category,
      required commercial_name,
      required scientific_name}) async {
    var response = await http.post(Connect._addMedicineAdmin, body: {
      "price": price,
      "end_date": end_state,
      "amount": amount,
      "company": company,
      "category": category,
      "t_name": commercial_name,
      "s_name": scientific_name,
      "_token": userInfo["_token"],
    });

    return _convertToMapAndGetBody(response: response);
  }

  static Future<Map<String, dynamic>> httpchangestateAdmin({
    required String id,
    required String state,
    required String payed,
  }) async {
    var response = await http.post(Connect._changestateAdmin, body: {
      "id": id,
      "state": state,
      "payed": payed,
      "_token": userInfo["_token"]
    });
    return _convertToMapAndGetBody(response: response);
  }

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
    return _convertToMapAndGetBody(response: response);
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
    return _convertToMapAndGetBody(response: response);
  }

  static Future<Map<String, dynamic>> httpLogoutMobile() async {
    final response = await http.post(
      _pharmacistLogoutUrlMobile,
      headers: authorizedHeader,
    );
    return _convertToMapAndGetBody(response: response);
  }

  static Future<Map<String, dynamic>> httpGetAllMedicinesMobile() async {
    final response =
        await http.get(_getAllMedicinesUrlMobile, headers: authorizedHeader);
    return _convertToMapAndGetBody(response: response);
  }
  //todo: fix this
  // static Future<Map<String, dynamic>> httpGetAllMedicinesWeb() async {
  //   final response =
  //   await http.get(_getAllMedicinesUrlWeb, headers: authorizedHeader);
  //   return _convertToMap(response: response);
  // }
  static Future<Map<String, dynamic>> httpShowDetailsMobile(
      {required int medicineID}) async {
    final response = await http.get(
        _showDetailsUrlMobile(medicineID: medicineID),
        headers: authorizedHeader);
    return _convertToMapAndGetBody(response: response);
  }

  static Future<Map<String, dynamic>> httpGetOrdersMobile() async {
    final response =
        await http.get(_getMedicineOrdersUrlMobile, headers: authorizedHeader);
    return _convertToMapAndGetBody(response: response);
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
    return _convertToMapAndGetBody(response: response);
  }

  static Future<Map<String, dynamic>> httpAddToFavoriteMobile(
      {required int medicineID}) async {
    final response = await http.post(addToFavoriteUrlMobile,
        headers: authorizedHeader,
        body: {"pharId": userID, "medId": medicineID});
    return _convertToMapAndGetBody(response: response);
  }

  static Future<Map<String, dynamic>> httpSearchMobile(
      {required String value}) async {
    final response = await http.post(_searchUrlMobile,
        headers: authorizedHeader, body: {"value": value});
    return _convertToMapAndGetBody(response: response);
  }
}
