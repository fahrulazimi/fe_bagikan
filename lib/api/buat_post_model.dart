import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class BuatPost {
  String message;

  BuatPost({this.message});

  factory BuatPost.createBuatPost(Map<String, dynamic> object) {
    return BuatPost(message: object["message"]);
  }

  static Future<BuatPost>buatPost(String token, String title, String description) async {
    String apiUrlBuatPost = "http://192.168.100.46:8000/api/post/create";
    String token = await getToken();

    var apiResult = await http.post(apiUrlBuatPost, 
    body: {
      "title": title, 
      "description": description,
      },
      headers: {
      'Authorization': "Bearer $token"},
      );
    var jsonObject = json.decode(apiResult.body); 

    return BuatPost.createBuatPost(jsonObject);
  }
}