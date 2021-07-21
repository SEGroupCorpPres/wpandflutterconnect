import 'package:http/http.dart' as http;
import 'package:wpandflutterconnect/model/login_model.dart';
import 'package:wpandflutterconnect/services/shared_service.dart';

class APIServices{
  static var client = http.Client();
  static var apiUrl = Uri.https('//192.168.0.105:8888/wpandflutterconnect', '/wp-json/jwt-auth/v1/token', {'q': '{http}'});

  static Future<bool> loginCustomer(String userName, String password) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded'
    };

    var response = await client.post(
      apiUrl,
      headers: requestHeaders,
      body: {
        'userName': userName,
        'password': password,
      }
    );

    if(response.statusCode == 200){
      var jsonString = response.body;
      LoginResponseModel responseModel = loginResponseFromJson(jsonString);
      if(responseModel.statusCode == 200){
        SharedService.setLoginDetails(responseModel);
      }
      return responseModel.statusCode == 200 ? true: false;
    }
    return false;
  }
}