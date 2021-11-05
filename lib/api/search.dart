import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class Search {
  String id;
  String title;
  String description;
  String like;
  String username;
  String userId;
  String picture;
  String profilePicture;
  String location;
  String createdAt;
  String category;
  String expired;
  
  
  Search({this.profilePicture, this.like, this.id, this.title, this.description, this.createdAt, this.userId, this.category, this.expired, this.location, this.picture, this.username});

  factory Search.createSearch(Map<String, dynamic> object) {
    return Search(
      like: object["like"].toString(),
      id: object["_id"],
      title: object["title"],
      description: object["description"],
      userId: object["userId"],
      category: object["category"],
      expired: object["expired"],
      location: object["location"],
      picture: object["picture"],
      createdAt: object["created_at"],
      username: object["username"],
      profilePicture: object["profilePicture"],
      );
  }

  static Future<List<Search>>getSearch(String token, String title, String kategori, String lokasi) async {
    String apiUrl = "http://192.168.100.46:8000/api/posts/search?title=$title&category=$kategori&location=$lokasi";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listPost = (jsonObject as Map<String, dynamic>)['data'];

    List<Search> posts = [];
    for(int i = 0; i < listPost.length; i ++)
      posts.add(Search.createSearch(listPost[i]));

    return posts;
  }
}
