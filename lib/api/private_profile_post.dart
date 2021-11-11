import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class PrivateProfilePost {
  String id;
  String userId;
  String picture;

  
  PrivateProfilePost({this.id, this.userId, this.picture});

  factory PrivateProfilePost.createPrivateProfilePost(Map<String, dynamic> object) {
    return PrivateProfilePost(
      id: object["_id"],
      userId: object["userId"],
      picture: object["picture"],

      );
  }

  static Future<List<PrivateProfilePost>>getPrivateProfilePost(String token) async {
    String apiUrl = "https://bagikan-backend.herokuapp.com/api/posts/read/profile";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listPost = (jsonObject as Map<String, dynamic>)['data'];

    List<PrivateProfilePost> posts = [];
    for(int i = 0; i < listPost.length; i ++)
      posts.add(PrivateProfilePost.createPrivateProfilePost(listPost[i]));

    return posts;
  }
}
