import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class Profile {
  String username;
  String email;
  String deskripsi;
  String nama;
  String phone;
  String profilePicture;
  String id;
  
  Profile({this.username, this.email, this.deskripsi, this.nama, this.phone, this.profilePicture, this.id});

  factory Profile.createProfile(Map<String, dynamic> object) {
    return Profile(
      username: object["username"],
      email: object["email"],
      deskripsi: object["description"],
      nama: object["name"],
      phone: object["phone"],
      profilePicture: object["profilePicture"],
      id: object["_id"],
      );
  }

  static Future<Profile>getProfile(String token) async {
    String apiUrl = "https://bagikan-backend.herokuapp.com/api/user/profile";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)["data"];

    return Profile.createProfile(userData);
  }
}
