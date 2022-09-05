import 'dart:convert';
import 'package:survei_asia/models/login_response.dart';
import 'package:survei_asia/models/register_response.dart';
import 'package:survei_asia/services/shared_service.dart';
import '../utils/config.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<bool> login(String email, String password) async {
    var requestHeader = {'Content-Type': "application/json; charset=utf-8"};

    var url = Uri.http(Config.apiUrl, Config.loginAPI);
    var data = {'email': email, 'password': password};

    var response = await client.post(url,
        headers: requestHeader, body: jsonEncode(data));

    print("Status Code : ${response.statusCode}");

    if (response.statusCode == 200) {
      var responseBody = response.body;
      LoginResponse loginResponse = loginResponseFromJson(responseBody);
      if(loginResponse.code == 0) {
        print("Login Sukses, Data Saved");
        SharedService.setLoginDetails(loginResponse);
        return true;
      }  else {
        print("Login Failed");
        return false;
      }
    }
    return false;
  }

  static Future<bool> register(String nama, String email, String password) async {
    var requestHeader = {'Content-Type': "application/json; charset=utf-8"};

    var url = Uri.http(Config.apiUrl, Config.registerAPI);
    var data = {'name' : nama, 'email': email, 'password': password};

    var response = await client.post(url,
        headers: requestHeader, body: jsonEncode(data));

    print("Status Code : ${response.statusCode}");

    if (response.statusCode == 200) {
      var responseBody = response.body;
      RegisterResponse registerResponseModel = registerModelFromJson(responseBody);
      if(registerResponseModel.code == 0) {
        print("Register Sukses, Lanjut proses login");
        return true;
      }  else {
        print("Register Failed ${registerResponseModel.message}");
        return false;
      }
    }
    return false;
  }
}
