import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class DeletePost {
  String message;

  
  DeletePost({this.message});

  factory DeletePost.createDeletePost(Map<String, dynamic> object) {
    return DeletePost(
      message: object["message"],
      );
  }

  static Future<DeletePost>deletePost(String token, String id) async {
    String apiUrl = "https://bagikan-backend.herokuapp.com/api/delete/post/$id";
    String token = await getToken();
    
    var apiResult = await http.delete(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    var userData = jsonObject;

    return DeletePost.createDeletePost(jsonObject);
  }
}
