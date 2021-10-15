import 'dart:convert';
import 'package:http/http.dart' as http;

class PostResult {
  String massage;

  PostResult({this.massage});

  factory PostResult.createPostResult(Map<String, dynamic> object) {
    return PostResult(massage: object['massage']);
  }

  static Future<PostResult> connectToAPI(
      String username, String email, String password) async {

    String apiUrlRegister = "http://192.168.100.46:5000/api/auth/register";

    var apiResult = await http.post(apiUrlRegister,
        body: {"username": username, "email": email, "password": password});
    var jsonObject = json.decode(apiResult.body);

    return PostResult.createPostResult(jsonObject); 
  }
  
}

class LoginResult {
  String massage;

  LoginResult({this.massage});

  factory LoginResult.createLoginResult(Map<String, dynamic> object) {
    return LoginResult(massage: object['massage']);
  }

static Future<LoginResult> login(
      String email, String password) async {

    String apiUrlLogin = "http://192.168.100.46:5000/api/auth/login";

    var apiResult = await http.post(apiUrlLogin,
        body: {"email": email, "password": password});
    var jsonObject = json.decode(apiResult.body);

    return LoginResult.createLoginResult(jsonObject); 
  }
}