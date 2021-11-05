import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class PublicProfile {
  String profilePicture;
  String username;
  String email;
  String description;
  String name;
  String id;
  
  PublicProfile({this.username, this.email, this.profilePicture, this.description, this.name, this.id});

  factory PublicProfile.createPublicProfile(Map<String, dynamic> object) {
    return PublicProfile(
      username: object["username"],
      email: object["email"],
      profilePicture: object["profilePicture"],
      description: object["description"],
      name: object["name"],
      id: object["_id"],
      );
  }

  static Future<PublicProfile>getPublicProfile(String token, String id) async {
    String apiUrl = "http://192.168.100.46:8000/api/user/$id";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)["data"];

    return PublicProfile.createPublicProfile(userData);
  }
}
