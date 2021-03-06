import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class EditProfile {
  String message;

  EditProfile({this.message});

  factory EditProfile.createEditProfile(Map<String, dynamic> object) {
    return EditProfile(message: object["message"]);
  }

  static Future<EditProfile>editProfile(String token, String nama, String deskripsi, String phone, String profilePicture ) async {
    String apiUrlEditProfile = "https://bagikan-backend.herokuapp.com/api/user/profile/update";
    String token = await getToken();

    var apiResult = await http.post(apiUrlEditProfile, 
    body: {
      "nama": nama, 
      "deskripsi": deskripsi,
      "phone" : phone,
      "profilePicture" : profilePicture,
      },
      headers: {
      'Authorization': "Bearer $token"},
      );
    var jsonObject = json.decode(apiResult.body); 

    return EditProfile.createEditProfile(jsonObject);
  }
}