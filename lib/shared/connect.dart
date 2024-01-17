import 'package:PharmacyApp/shared/medicine.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const String usedIpAdmin = '127.0.0.1';
const String usedIPPharmacist = '10.0.2.2';

typedef futureMap = Future<Map<String, dynamic>>;

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
    var respondBody =
        _convertToMapAndGetBodyWithNoCheckForStatuesNumber(response: response);
    if (respondBody["statusNumber"] == 200) {
      return respondBody;
    } else {
      throw Exception(respondBody["message"]);
    }
  }

  static Map<String, dynamic>
      _convertToMapAndGetBodyWithNoCheckForStatuesNumber(
          {required http.Response response}) {
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final respondBody = jsonDecode(response.body);
      print(respondBody.toString());
      return respondBody;
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
      Uri.parse('http://$usedIPPharmacist:8000/api/search');
  static final _searchUrlWeb = Uri.parse('http://$usedIpAdmin:8000/search');

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

  static _order_datails_mobile({required orderNumber}) =>
      Uri.parse('http://$usedIpAdmin:8000/order-datails/api/$orderNumber');

  static final _getAllMedicinesUrlWeb =
      Uri.parse('http://$usedIpAdmin:8000/all-medicine');

  static futureMap orderDetails(
      {required int orderNumber, required Mode mode}) async {
    var response = mode == Mode.Mobile
        ? await http
            .get(Connect._order_datails_mobile(orderNumber: orderNumber))
        : await http.get(Connect._order_datails(orderNumber: orderNumber));
    return _convertToMapAndGetBody(response: response);
  }

  static futureMap getOrdersAdmin() async {
    var response = await http.get(Connect._getOrdersAdmin);
    return _convertToMapAndGetBody(response: response);
  }

  static futureMap getCsrfToken() async {
    var response = await http.get(Connect._csrf_tokenAdmin);
    return _convertToMapAndGetBodyWithNoCheckForStatuesNumber(response: response);
  }

  static futureMap loginAdmin(
      {required String username, required String password}) async {
    var rBody = await Connect.getCsrfToken();
    var csrfToken = rBody["csrf_token"];
    var sessionID = rBody["yousef_session"];
    var response = await http.post(
      Uri.parse('http://$usedIpAdmin:8000/login'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        "_token": csrfToken.toString(),
        "username": username.toString(),
        "password": password.toString(),
      },
    );
    print(response.statusCode);
    print(response.statusCode);
    userInfo = {
      "_token": csrfToken,
      "username": username,
      "password": password,
      "yousef_session": sessionID,
    };
    return _convertToMapAndGetBodyWithNoCheckForStatuesNumber(response: response);
  }

  static futureMap logoutAdmin() async {
    var response = await http.get(
      _logoutAdmin,
    );
    return _convertToMapAndGetBody(response: response);
  }

  static futureMap httpAddMedicineAdmin(
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

    return _convertToMapAndGetBodyWithNoCheckForStatuesNumber(response: response);
  }

  static futureMap httpchangestateAdmin({
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
    print(response.body);
    return _convertToMapAndGetBodyWithNoCheckForStatuesNumber(response: response);
  }

  static futureMap httpLoginMobile(
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

  static futureMap httpRegisterMobile(
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

  static futureMap httpLogoutMobile() async {
    final response = await http.post(
      _pharmacistLogoutUrlMobile,
      headers: authorizedHeader,
    );
    return _convertToMapAndGetBody(response: response);
  }

  static futureMap httpGetAllMedicinesMobile() async {
    final response =
        await http.get(_getAllMedicinesUrlMobile, headers: authorizedHeader);
    return _convertToMapAndGetBody(response: response);
  }

  static futureMap httpGetAllMedicinesWeb() async {
    final response = await http.get(
      _getAllMedicinesUrlWeb,
    );
    return _convertToMapAndGetBody(response: response);
  }

  static futureMap getMedicineInformationMobile({required int medicineID}) async {
    final response = await http.get(
        _showDetailsUrlMobile(medicineID: medicineID),
        headers: authorizedHeader);
    return _convertToMapAndGetBody(response: response);
  }

  static futureMap httpGetOrdersMobile() async {
    final response =
        await http.get(_getMedicineOrdersUrlMobile, headers: authorizedHeader);
    return _convertToMapAndGetBodyWithNoCheckForStatuesNumber(
        response: response);
  }

  static futureMap httpGetOrderDetailsMobile() async {
    final response =
        await http.get(_getMedicineOrdersUrlMobile, headers: authorizedHeader);
    return _convertToMapAndGetBody(response: response);
  }

  static futureMap orderMobile(
      {required List<int> medicineIDs, required List<int> quantities}) async {
    List<String> medicineIDsStrings = List.generate(
        medicineIDs.length, (index) => medicineIDs[index].toString());
    List<String> quantitiesStrings = List.generate(
        quantities.length, (index) => quantities[index].toString());

    final body = {
      "pharmacist_id": userID,
      "medicine_Ids": medicineIDsStrings,
      "quan": quantitiesStrings
    };
    final response = await http.post(_orderMedicinesUrlMobile,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userInfo["api_token"]}"
        },
        body: jsonEncode(body));

    return _convertToMapAndGetBody(response: response);
  }

  static futureMap addToFavoriteMobile({required int medicineID}) async {
    final response = await http.post(addToFavoriteUrlMobile, headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${userInfo["api_token"]}"
    }, body: {
      "pharId": userID,
      "medId": medicineID
    });
    return _convertToMapAndGetBody(response: response);
  }

  static futureMap httpSearchMobile({required String value}) async {
    final response = await http.post(_searchUrlMobile,
        headers: authorizedHeader, body: jsonEncode({"value": value}));
    return _convertToMapAndGetBodyWithNoCheckForStatuesNumber(response: response);
  }

  static futureMap httpSearchWeb({required String value}) async {
    final response = await http.post(_searchUrlWeb,
        headers: {'Content-Type': "application/x-www-form-urlencoded"},
        body: {"_token": userInfo["_token"], "value": value});
    return _convertToMapAndGetBodyWithNoCheckForStatuesNumber(response: response);
  }
}
