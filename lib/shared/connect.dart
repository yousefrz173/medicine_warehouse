import 'package:PharmacyApp/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'package:PharmacyApp/mobile/current_user.dart';

class Connect {
  static final Uri _login_url_mobile =
      Uri.parse('http://$BackendRoutMobile:8000/api/login');
  static final Uri _register_url_mobile =
      Uri.parse('http://$BackendRoutMobile:8000/api/register');

  static Future<http.Response> http_login_mobile(String authDataJson) async =>
      await http.post(_login_url_mobile,
          body: authDataJson, headers: {'Content-Type': 'application/json'});

  static Future<http.Response> http_register_mobile(
          String authDataJson) async =>
      await http.post(
        _register_url_mobile,
        body: authDataJson,
        headers: {
          'Content-Type': 'application/json',
        },
      );

  static Future<http.Response> http_logout_mobile() async {
    return await http.post(
      Uri.parse('http://$BackendRoutMobile:8000/api/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userInfo["api_token"]}"
      },
    );
  }

}
