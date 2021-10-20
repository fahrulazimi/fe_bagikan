
import 'package:fe_bagikan/helper/layout.dart';
import 'package:fe_bagikan/pages/buat_post.dart';
import 'package:fe_bagikan/pages/profile.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // List<Widget> post = [];

  // _HomepageState(){
  //   for(int i = 0; i<1;i++)
  //   post.add(Image(image: image))
  // }


  @override

  Widget build(BuildContext context) {
    TabBar myTabBar = TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home),),
            Tab(icon: Icon(Icons.search),),
            Tab(icon: Icon(Icons.add),),
            Tab(icon: Icon(Icons.person),),
          ]
        );

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: <Widget> [
            //homepage
            Center(child: Text("tab1"),),

            //search
            Center(child: Text("tab2"),),

            //createPost
            BuatPostPage(),
            //profile
            ProfilePage()

          ],
        ),
        bottomNavigationBar: Container(color:Color(0xff1443C3), child: myTabBar)
      )
      
      
    );
  }
}