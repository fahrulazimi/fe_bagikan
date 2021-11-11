import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class LikePost {
  String postId;
  String like;

  LikePost({this.like, this.postId});

  factory LikePost.createLikePost(Map<String, dynamic> object) {
    return LikePost(
      postId: object["postId"],
      like: object["like"].toString()
      );
  }

  static Future<LikePost>likePost(String token, String id) async {
    String apiUrlLikePost = "https://bagikan-backend.herokuapp.com/api/post/like/$id";
    String token = await getToken();

    var apiResult = await http.post(apiUrlLikePost, 
      headers: {
      'Authorization': "Bearer $token"},
      );
    var jsonObject = json.decode(apiResult.body); 
    var userLikeData = (jsonObject as Map<String, dynamic>)["data"];

    return LikePost.createLikePost(userLikeData);
  }
}

class DislikePost {
  String postId;
  String like;

  DislikePost({this.like, this.postId});

  factory DislikePost.createDislikePost(Map<String, dynamic> object) {
    return DislikePost(
      postId: object["postId"],
      like: object["like"].toString()
      );
  }

  static Future<DislikePost>dislikePost(String token, String id) async {
    String apiUrlDislikePost = "https://bagikan-backend.herokuapp.com/api/post/dislike/$id";
    String token = await getToken();

    var apiResult = await http.post(apiUrlDislikePost, 
      headers: {
      'Authorization': "Bearer $token"},
      );
    var jsonObject = json.decode(apiResult.body); 
    var userDislikeData = (jsonObject as Map<String, dynamic>)["data"];

    return DislikePost.createDislikePost(userDislikeData);
  }
}

class GetLike {
  String postId;
  String userId;
  String statusLike;
  
  GetLike({this.postId, this.statusLike, this.userId});

  factory GetLike.createGetLike(Map<String, dynamic> object) {
    return GetLike(
      postId: object["postId"],
      statusLike: object["statusLike"].toString(),
      userId: object["userId"],
      );
  }

  static Future<GetLike>getGetLike(String token, String id) async {
    String apiUrl = "https://bagikan-backend.herokuapp.com/api/post/getLike/$id";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)["data"];
  
    return GetLike.createGetLike(userData);
  }
}