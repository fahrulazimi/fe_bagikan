import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:fe_bagikan/pages/login_page.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            titleWidget: Center(
              child: Text(
                "Sumbangin",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            bodyWidget: Center(
              child: Text(
                "Membantu untuk menyumbangkan barang bekas layak pakaimu agar sampai pada orang yang tepat",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            image: Image.asset("assets/images/onboarding1.png"),
            decoration: PageDecoration(
                contentMargin: EdgeInsets.only(left: 50, right: 50),
                pageColor: Colors.white,
                imagePadding: EdgeInsets.only(top: 80)),
          ),
          PageViewModel(
            titleWidget: Center(
              child: Text(
                "Cari Barang",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            bodyWidget: Center(
              child: Text(
                "Membantu untuk mencari barang bekas layak pakai yang kamu butuhkan.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            image: Image.asset("assets/images/onboarding2.png"),
            decoration: PageDecoration(
                contentMargin: EdgeInsets.only(left: 50, right: 50),
                pageColor: Colors.white,
                imagePadding: EdgeInsets.only(top: 80)),
          ),
          PageViewModel(
            titleWidget: Center(
              child: Text(
                "Himbauan",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            bodyWidget: Center(
              child: Text(
                "Hati-hati terhadap penipuan, selalu waspada saat mencari dan menyumbangkan barang bekasmu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            image: Image.asset("assets/images/onboarding3.png"),
            decoration: PageDecoration(
                contentMargin: EdgeInsets.only(left: 50, right: 50),
                pageColor: Colors.white,
                imagePadding: EdgeInsets.only(top: 80)),
          )
        ],
        onDone: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        showSkipButton: true,
        showNextButton: true,
        animationDuration: 1000,
        curve: Curves.fastOutSlowIn,
        dotsDecorator: DotsDecorator(
            spacing: EdgeInsets.all(5),
            activeColor: Color(0xff1443C3),
            activeSize: Size(15, 7.5),
            size: Size.square(7.5),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        skip: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xff1443C3))),
          child: Center(
            child: Text(
              "SKIP",
              style: TextStyle(fontSize: 14, color: Color(0xff1443C3)),
            ),
          ),
        ),
        next: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xff1443C3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "NEXT",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
        done: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xff1443C3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Text(
                  "START",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
