import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile"),
        ),
      body: SingleChildScrollView(
        child: Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80")
                      )
                    ),
                    ),
                    SizedBox(height: 10,),
                    Text("Riley Masteria Rose"),
                    SizedBox(height: 10,),
                    Text("i love bicycle"),
                    SizedBox(height: 10,),
                    Container(height: 1, width: double.infinity ,color: Colors.black,),
                    SizedBox(height: 1,),
                    Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height:  MediaQuery.of(context).size.width /2 ,
                                  width: MediaQuery.of(context).size.width /2 ,
                                  padding: EdgeInsets.all(2),
                                  child: Image(
                                    image: NetworkImage(
                                      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
                                      fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height:  MediaQuery.of(context).size.width /2 ,
                                  width: MediaQuery.of(context).size.width /2 ,
                                  padding: EdgeInsets.all(2),
                                  child: Image(
                                    image: NetworkImage(
                                      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
                                      fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height:  MediaQuery.of(context).size.width /2 ,
                                  width: MediaQuery.of(context).size.width /2 ,
                                  padding: EdgeInsets.all(2),
                                  child: Image(
                                    image: NetworkImage(
                                      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
                                      fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height:  MediaQuery.of(context).size.width /2 ,
                                  width: MediaQuery.of(context).size.width /2 ,
                                  padding: EdgeInsets.all(2),
                                  child: Image(
                                    image: NetworkImage(
                                      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
                                      fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                ],
                ),
        ),
        ), 
    );
  }
}