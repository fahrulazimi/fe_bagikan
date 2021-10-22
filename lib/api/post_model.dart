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
  String token;

  LoginResult({this.token});

  factory LoginResult.createLoginResult(Map<String, dynamic> object) {
    return LoginResult(token: object["token"]);
  }

  static Future<LoginResult>login(String username, String password) async {
    String apiUrlLogin = "http://192.168.100.46:8000/api/login";

    var apiResult = await http.post(apiUrlLogin, 
    body: {"username": username, "password": password});
    var jsonObject = json.decode(apiResult.body); 

    return LoginResult.createLoginResult(jsonObject);
  }
}

class AdminLoginResult {
  String token;

  AdminLoginResult({this.token});

  factory AdminLoginResult.createAdminLoginResult(Map<String, dynamic> object) {
    return AdminLoginResult(token: object["token"]);
  }

  static Future<AdminLoginResult>adminLogin(String username, String password) async {
    String apiUrlAdminLogin = "http://192.168.100.46:8000/api/login/admin";

    var apiResult = await http.post(apiUrlAdminLogin, 
    body: {"username": username, "password": password});
    var jsonObject = json.decode(apiResult.body); 

    return AdminLoginResult.createAdminLoginResult(jsonObject);
  }
}