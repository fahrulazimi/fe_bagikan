import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class Posts {
  String like;
  String id;
  String title;
  String description;
  String createdAt;
  
  Posts({this.like, this.id, this.title, this.description, this.createdAt});

  factory Posts.createPosts(Map<String, dynamic> object) {
    return Posts(
      like: object["like"].toString(),
      id: object["_id"],
      title: object["title"],
      description: object["description"],
      createdAt: object["createdAt"],
      );
  }

  static Future<List<Posts>>getPosts(String token) async {
    String apiUrl = "http://192.168.100.46:8000/api/posts";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listPost = jsonObject;

    List<Posts> posts = [];
    for(int i = 0; i < listPost.length; i ++)
      posts.add(Posts.createPosts(listPost[i]));

    return posts;
  }
}
