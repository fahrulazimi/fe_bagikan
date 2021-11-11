import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("token");
}

// class BuatPost {
//   String message;

//   BuatPost({this.message});

//   factory BuatPost.createBuatPost(Map<String, dynamic> object) {
//     return BuatPost(message: object["message"]);
//   }

//   static Future<BuatPost> 
  
  void buatPost(
      String token, String title, String description, File _picturePost) async {
    try {
      String token = await getToken();
      Map<String, dynamic> data = {};

      if (_picturePost != null) {
        data["picture"] = await MultipartFile.fromFile(
          _picturePost.path,
          contentType: new MediaType("image", "jpeg"),
        );
        data["title"] = title;
        data["description"] = description;
      }

      Response res = await Dio().post(
        "https://bagikan-backend.herokuapp.com/api/post/create",
        data: FormData.fromMap(data),
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
        onSendProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "&");
          }
        },
      );
      print(json.decode(res.toString()));
      
    } catch (e) {
      print(e);
    }
  }
// }
