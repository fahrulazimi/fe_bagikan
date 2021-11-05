import 'package:fe_bagikan/pages/dashboard_admin/adminPost.dart';
import 'package:fe_bagikan/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fe_bagikan/pages/dashboard_admin/adminUser.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    TabBar myTabBar = TabBar(tabs: <Widget>[
      Tab(
        icon: Icon(Icons.person_outline),
      ),
      Tab(
        icon: Icon(Icons.post_add),
      ),
    ]);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Dashboard Admin"),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.logout,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()), (route)=>false);
                    }),
              ],
            ),
            body: TabBarView(
              children: <Widget>[
                //user
                AdminUser(),
                //postingan
                AdminPost()
              ],
            ),
            bottomNavigationBar:
                Container(color: Color(0xff1443C3), child: myTabBar)));
  }
}
