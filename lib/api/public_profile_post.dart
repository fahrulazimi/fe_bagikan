import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class PublicProfilePost {
  String id;
  String title;
  String description;
  String like;
  String userId;
  String picture;
  String location;
  String category;
  String expired;
  String createdAt;
  String nama;

  
  PublicProfilePost({this.like, this.id, this.title, this.description, this.createdAt, this.userId, this.category, this.expired, this.location, this.picture, this.nama});

  factory PublicProfilePost.createPublicProfilePost(Map<String, dynamic> object) {
    return PublicProfilePost(
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
      nama: object["name"],
      );
  }

  static Future<List<PublicProfilePost>>getPublicProfilePost(String token, String id) async {
    String apiUrl = "https://bagikan-backend.herokuapp.com/api/posts/read_id/$id";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listPost = (jsonObject as Map<String, dynamic>)['data'];

    List<PublicProfilePost> posts = [];
    for(int i = 0; i < listPost.length; i ++)
      posts.add(PublicProfilePost.createPublicProfilePost(listPost[i]));

    return posts;
  }
}
