import 'dart:convert';
import 'package:http/http.dart' as http;

class PostResult {
  String message;

  PostResult({this.message});

  factory PostResult.createPostResult(Map<String, dynamic> object) {
    return PostResult(message: object["message"]);
  }

  static Future<PostResult> connectToAPI(
      String username, String email, String password) async {
    String apiUrlRegister = "http://192.168.100.46:8000/api/register";

    var apiResult = await http.post(apiUrlRegister,
        body: {"username": username, "email": email, "password": password});
    var jsonObject = json.decode(apiResult.body);

    return PostResult.createPostResult(jsonObject);
  }
}

class LoginResult {
  String message;

  LoginResult({this.message});

  factory LoginResult.createLoginResult(Map<String, dynamic> object) {
    return LoginResult(message: object["message"]);
  }

  static Future<LoginResult>login(String username, String password) async {
    String apiUrlLogin = "http://192.168.100.46:8000/api/login/admin";

    var apiResult = await http.post(apiUrlLogin, 
    body: {"username": username, "password": password});
    var jsonObject = json.decode(apiResult.body);

    return LoginResult.createLoginResult(jsonObject);
  }
}
