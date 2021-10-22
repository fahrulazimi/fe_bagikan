import 'package:fe_bagikan/pages/dashboard_admin/adminDashobard.dart';
import 'package:fe_bagikan/pages/editProfile.dart';
import 'package:fe_bagikan/pages/homepage.dart';
import 'package:fe_bagikan/pages/login_page.dart';
import 'package:fe_bagikan/pages/profile2.dart';
import 'package:flutter/material.dart';
import 'pages/splashscreen.dart';
import 'package:fe_bagikan/constant/feed_back_json.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      home: LoginPage(),
    );
  }
}
