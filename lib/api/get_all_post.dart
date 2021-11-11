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
  String userId;
  String picture;
  String location;
  String category;
  String expired;
  String username;
  String profilePicture;

  
  Posts({this.profilePicture, this.like, this.id, this.title, this.description, this.createdAt, this.userId, this.category, this.expired, this.location, this.picture, this.username});

  factory Posts.createPosts(Map<String, dynamic> object) {
    return Posts(
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

  static Future<List<Posts>>getPosts(String token) async {
    String apiUrl = "https://bagikan-backend.herokuapp.com/api/posts/read";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listPost = (jsonObject as Map<String, dynamic>)['data'];

    List<Posts> posts = [];
    for(int i = 0; i < listPost.length; i ++)
      posts.add(Posts.createPosts(listPost[i]));

    return posts;
  }
}
