import 'package:fe_bagikan/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'pages/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      home: Homepage(),
    );
  }
}

