import 'package:flutter/material.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'dart:async';
import 'package:fe_bagikan/pages/onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnBoarding()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff1443C3),
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: SizeConfig.blockHorizontal * 22,
          height: SizeConfig.blockVertical * 22,
        ),
      ),
    );
  }
}
