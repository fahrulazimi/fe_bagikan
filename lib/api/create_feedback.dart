import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

class BuatFeedback {
  String message;

  BuatFeedback({this.message});

  factory BuatFeedback.createBuatFeedback(Map<String, dynamic> object) {
    return BuatFeedback(message: object["message"]);
  }

  static Future<BuatFeedback>buatFeedback(String token, String id, String description ) async {
    String apiUrlBuatFeedback = "http://192.168.100.46:8000/api/feedback/create/$id";
    String token = await getToken();

    var apiResult = await http.post(apiUrlBuatFeedback, 
    body: {
      "description": description,

      },
      headers: {
      'Authorization': "Bearer $token"},
      );
    var jsonObject = json.decode(apiResult.body); 

    return BuatFeedback.createBuatFeedback(jsonObject);
  }
}