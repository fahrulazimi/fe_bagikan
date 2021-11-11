import 'dart:convert';
import 'dart:io';
import 'package:fe_bagikan/constant/feed_back_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class FeedBackPrivate {
  String id;
  String description;
  String createdAt;
  String idSender;
  String idReceiver;
  String username;
  String profilePictureSender;

  
  FeedBackPrivate({this.profilePictureSender, this.id, this.description, this.createdAt, this.idReceiver, this.idSender, this.username});

  factory FeedBackPrivate.createFeedBackPrivate(Map<String, dynamic> object) {
    return FeedBackPrivate(
      id: object["_id"],
      description: object["description"],
      createdAt: object["created_at"],
      idReceiver: object["idReceiver"],
      idSender: object["idSender"],
      username: object["usernameSender"],
      profilePictureSender: object["profilePictureSender"]

      );
  }

  static Future<List<FeedBackPrivate>>getFeedBackPrivate(String token, String id) async {
    String apiUrl = "https://bagikan-backend.herokuapp.com/api/feedback/$id";
    String token = await getToken();
    
    var apiResult = await http.get(apiUrl, 
    headers: {
      'Authorization': "Bearer $token"},
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listFeedBack = jsonObject;

    List<FeedBackPrivate> feedback = [];
    for(int i = 0; i < listFeedBack.length; i ++)
      feedback.add(FeedBackPrivate.createFeedBackPrivate(listFeedBack[i]));

    return feedback;
  }
}
