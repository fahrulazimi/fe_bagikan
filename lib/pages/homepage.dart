
import 'dart:developer';

import 'package:fe_bagikan/helper/layout.dart';
import 'package:fe_bagikan/pages/buat_post.dart';
import 'package:fe_bagikan/pages/profile.dart';
import 'package:fe_bagikan/pages/search_page.dart';
import 'package:fe_bagikan/pages/timeline.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key key,
    this.tabIndex,
  }) : super(key: key);

  final int tabIndex;
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

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
      initialIndex: widget.tabIndex,
      child: Scaffold(
        body: TabBarView(
          children: <Widget> [
            //homepage
            TimelinePage(),
            //search
            SearchPage(),
            
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