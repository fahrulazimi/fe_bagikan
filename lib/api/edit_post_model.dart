import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class EditPost {
  String message;

  EditPost({this.message});

  factory EditPost.createEditPost(Map<String, dynamic> object) {
    return EditPost(message: object["message"]);
  }

  static Future<EditPost>editPost(String token, String nama, String deskripsi, String phone, String profilePicture ) async {
    String apiUrlEditPost = "http://192.168.100.46:8000/api/post/update";
    String token = await getToken();

    var apiResult = await http.post(apiUrlEditPost, 
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

    return EditPost.createEditPost(jsonObject);
  }
}