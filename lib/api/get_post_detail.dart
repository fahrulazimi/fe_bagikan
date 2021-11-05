import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class PostDetail {
  String like;
  String id;
  String title;
  String description;
  String createdAt;
  String userId;
  String picture;
  String location;
  String category;
  String expired;
  String username;
  String profilePicture;
  String phone;
  
  PostDetail({this.like, this.id, this.title, this.description,  this.userId, this.category, this.expired, this.location, this.picture, this.createdAt, this.username, this.profilePicture, this.phone});

  factory PostDetail.createPostDetail(Map<String, dynamic> object) {
    return PostDetail(
      title: object["title"],
      description: object["description"],
      like: object["like"].toString(),
      userId: object["userId"],
      picture: object["picture"],
      location: object["location"],
      category: object["category"],
      expired: object["expired"],
      createdAt: object["created_at"],
      username: object["username"],
      profilePicture: object["profilePicture"],
      phone: object["phone"], 
      );
  }

  static Future<PostDetail>getPostDetail(String token, String id) async {
    String apiUrl = "http://192.168.100.46:8000/api/post/detail/$id";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)["data"];

    return PostDetail.createPostDetail(userData);
  }
}
