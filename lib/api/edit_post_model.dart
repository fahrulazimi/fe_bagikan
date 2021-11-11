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

  static Future<EditPost>editPost(String token, String id, String title, String description, String location, String picture, String category, String expired ) async {
    String apiUrlEditPost = "https://bagikan-backend.herokuapp.com/api/post/update/$id";
    String token = await getToken();

    var apiResult = await http.post(apiUrlEditPost, 
    body: {
      "title": title, 
      "description": description,
      "location" : location,
      "picture" : picture,
      "category" : category,
      "expired" : expired,

      },
      headers: {
      'Authorization': "Bearer $token"},
      );
    var jsonObject = json.decode(apiResult.body); 

    return EditPost.createEditPost(jsonObject);
  }
}