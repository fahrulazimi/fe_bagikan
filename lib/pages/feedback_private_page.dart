import 'package:fe_bagikan/api/feedack_private.dart';
import 'package:fe_bagikan/api/private_profile_post.dart';
import 'package:fe_bagikan/api/public_profile_post.dart';
import 'package:fe_bagikan/api/user_model.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:fe_bagikan/pages/detailPost.dart';
import 'package:fe_bagikan/pages/editProfile.dart';
import 'package:fe_bagikan/pages/login_page.dart';
import 'package:fe_bagikan/pages/profile2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedBackPrivatePage extends StatefulWidget {
  const FeedBackPrivatePage({
    Key key,
    this.id,
  }) : super(key: key);

  final String id;

  @override
  _FeedBackPrivatePageState createState() => _FeedBackPrivatePageState();
}

class _FeedBackPrivatePageState extends State<FeedBackPrivatePage> {
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  String token;
  Profile profile;
  List<dynamic> listPost = [];
  PrivateProfilePost privateProfilePost;
  List<dynamic> listFeedBack = [];

  @override
  void initState() {
    super.initState();
    getToken().then((s) {
      token = s;
        print(token);
        Profile.getProfile(token).then((value) {
          profile = value;
          if (mounted) {
          setState(() {
            print(profile);
          });
        }
        });
        PrivateProfilePost.getPrivateProfilePost(token).then((value) {
          listPost = value;
          if (mounted) {
            setState(() {
              print(listPost);
            });
          }
        });
        FeedBackPrivate.getFeedBackPrivate(token, widget.id).then((value) {
          print(widget.id);
          listFeedBack = value;
          if (mounted) {
            setState(() {
              print(listFeedBack);
            });
          }
        });
      if(mounted){setState(() {});}
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
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text((profile != null ) ? ((profile.nama != null ) ? profile.nama:"noname") : "noname"),
              accountEmail: Text((profile != null) ? profile.email : ""),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage((profile != null)
                    ? profile.profilePicture
                    : "https://nd.net/wp-content/uploads/2016/04/profile-dummy.png"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "Edit Profile",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: (){
                  Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()), (route)=>false);}
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
                        image: (profile != null)
                            ? NetworkImage(
                                profile.profilePicture)
                            : NetworkImage(
                                "https://nd.net/wp-content/uploads/2016/04/profile-dummy.png"))),
              ),
              SizedBox(
                height: 10,
              ),
              Text((profile != null ) ? ((profile.nama != null ) ? profile.nama:"noname") : "noname"),
              SizedBox(
                height: 10,
              ),
              Text((profile != null ) ? ((profile.deskripsi!= null ) ? profile.deskripsi:"Bio") : "Bio"),
              SizedBox(
                height: 10,
              ),
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
                width: SizeConfig.blockHorizontal * 100,
                child: SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                          (listFeedBack != [] ? listFeedBack.length : 0),
                          (index) {
                    if (listFeedBack != []) {
                      var revesedListFeedback = List.of(listFeedBack.reversed);
                      String time = revesedListFeedback[index].createdAt;
                      DateTime dateTime = DateTime.parse(time);
                      var formatedTanggal = new DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
                      timeago.setLocaleMessages('id', timeago.IdMessages());
                      return GetFeedback(
                        profileImg:revesedListFeedback[index].profilePictureSender,
                        name: revesedListFeedback[index].username,
                        deskripsi: revesedListFeedback[index].description,
                        timeAgo: timeago.format(DateTime.parse(time), locale: 'id'),
                      );
                    }
                  })),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GetFeedback extends StatefulWidget {
  const GetFeedback(
      {Key key, this.deskripsi, this.name, this.profileImg, this.timeAgo})
      : super(key: key);

  final String profileImg;
  final String name;
  final String deskripsi;
  final String timeAgo;

  @override
  State<GetFeedback> createState() => _GetFeedbackState();
}

class _GetFeedbackState extends State<GetFeedback> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 15),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.profileImg))),
              ),
              Text(
                widget.name,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.only(left: 55),
              alignment: Alignment.topLeft,
              child: Text(widget.deskripsi)),
          Container(
            margin: EdgeInsets.only(left: 55),
            alignment: Alignment.topLeft,
            child: Text(widget.timeAgo,
                style: TextStyle(fontSize: 9, color: Colors.grey)),
          )
        ],
      ),
    );
  }
}
