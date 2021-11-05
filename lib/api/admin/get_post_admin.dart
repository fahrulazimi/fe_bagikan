import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class Post {
  String id;
  String title;
  String description;

  
  Post({this.description, this.id, this.title});

  factory Post.createPost(Map<String, dynamic> object) {
    return Post(
      id: object["_id"],
      description: object["description"],
      title: object["title"],
      );
  }

  static Future<List<Post>>getPost(String token) async {
    String apiUrl = "http://192.168.100.46:8000/api/posts";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listPost = jsonObject;

    List<Post> post = [];
    for(int i = 0; i < listPost.length; i ++)
      post.add(Post.createPost(listPost[i]));

    return post;
  }
}
