import 'package:fe_bagikan/constant/feed_back_json.dart';
import 'package:fe_bagikan/constant/post_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile2Page extends StatefulWidget {
  @override
  _Profile2PageState createState() => _Profile2PageState();
}

class _Profile2PageState extends State<Profile2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback"),),
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
                      children: <Widget> [
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image:NetworkImage(feedback[0]['profileImg']), fit: BoxFit.cover )
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(feedback[0]['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          ]
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: 
                          Text(feedback[0]['feedBack'], style: TextStyle(fontSize: 14)),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: 
                          Text(feedback[0]['timeAgo'], style: TextStyle(fontSize: 9, color: Colors.grey)),
                        ),


                      ],

                    )
                ],
                ),
        ),
        ), 
    );
  }
}