import 'package:PharmacyApp/shared/shared.dart';
import 'package:http/http.dart' as http;

class Connect {
  static Uri login_url_mobile = Uri.parse(
      'http://$BackendRoutMobile:8000/api/login');

  ;


  static Future<http.Response> http_login_mobile(authDataJsonString) async =>
      await http.post(
          login_url_mobile,
          body: authDataJsonString,
          headers: {'Content-Type': 'application/json'});

}
