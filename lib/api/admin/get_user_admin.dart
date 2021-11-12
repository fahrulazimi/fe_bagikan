import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class User {
  String id;
  String username;
  String email;

  
  User({this.email, this.id, this.username});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
      id: object["_id"],
      username: object["username"],
      email: object["email"],
      );
  }

  static Future<List<User>>getUser(String token) async {
    String apiUrl = "https://bagikan-backend.herokuapp.com/api/users";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listUser = jsonObject;

    List<User> user = [];
    for(int i = 0; i < listUser.length; i ++)
      user.add(User.createUser(listUser[i]));

    return user;
  }
}
