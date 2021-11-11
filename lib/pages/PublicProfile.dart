import 'dart:math';

import 'package:fe_bagikan/api/get_profile_public.dart';
import 'package:fe_bagikan/api/public_profile_post.dart';
import 'package:fe_bagikan/api/user_model.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:fe_bagikan/pages/detailPost.dart';
import 'package:fe_bagikan/pages/detailPostPublic.dart';
import 'package:fe_bagikan/pages/editProfile.dart';
import 'package:fe_bagikan/pages/feedback_private_page.dart';
import 'package:fe_bagikan/pages/feedback_public_page.dart';
import 'package:fe_bagikan/pages/profile2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicProfilePage extends StatefulWidget {
  const PublicProfilePage({
    Key key,
    bool isLiked,
    this.id,
  }) : super(key: key);

  final String id;
  @override
  _PublicProfilePageState createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {

  
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }

  String token;
  Profile profile;
  PublicProfile publicProfile;
  List<dynamic> listPost = [];
  PublicProfilePost publicProfilePost;

  @override
  void initState() {
    super.initState();
    getToken().then((s) {
      token = s;
      setState(() {
        print(token);
        PublicProfile.getPublicProfile(token, widget.id).then((value) {
          publicProfile = value;
          setState(() {
            print(publicProfile);
          });
        });
        Profile.getProfile(token).then((value) {
          profile = value; 
          setState(() {
            print(profile);
            });
          });
        PublicProfilePost.getPublicProfilePost(token, widget.id).then((posts) {
          listPost = posts;
          setState(() {
            print(posts.length);
            print(listPost);
            print(listPost[0].title);
          });
        });
      });
    });
  }

  

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/logo.png"),
                  )),
            ),
            Text(
              "Bagikan",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
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
                            (publicProfile != null)?publicProfile.profilePicture :"https://nd.net/wp-content/uploads/2016/04/profile-dummy.png"))),
              ),
              SizedBox(
                height: 10,
              ),
              Text((publicProfile != null) ? publicProfile.name : ""),
              SizedBox(
                height: 10,
              ),
              Text((publicProfile != null) ? publicProfile.description : ""),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: GestureDetector(
                      child: Container(
                        height: 20,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff1443C3),
                        ),
                        child: Center(
                            child: Text(
                          "Feedback",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                      onTap: () {
                        if(publicProfile.id == profile.id){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedBackPrivatePage(id: profile.id)));
                        }
                        else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(  
                                builder: (context) => FeedBackPublicPage(id: widget.id,)));
                        }
                      })),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.black,
              ),
              SizedBox(
                height: 1,
              ),
              
              Container(
                height: SizeConfig.blockHorizontal*100,
                width: SizeConfig.blockHorizontal*100,
                child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    children: 
                    List.generate((listPost != [] ? listPost.length : 0), (index) {
                  if (listPost != []) {
                    return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        child: Image(
                          image: NetworkImage(listPost[index].picture),
                          fit: BoxFit.cover,
                      )),
                      onTap: (){
                        setState(() {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => DetailPostPublicPage(id :listPost[index].id)));
                            });
                      },
                    );
                  }
                })
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



