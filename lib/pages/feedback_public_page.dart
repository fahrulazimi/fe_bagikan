import 'package:fe_bagikan/api/create_feedback.dart';
import 'package:fe_bagikan/api/feedack_private.dart';
import 'package:fe_bagikan/api/get_profile_public.dart';
import 'package:fe_bagikan/api/private_profile_post.dart';
import 'package:fe_bagikan/api/public_profile_post.dart';
import 'package:fe_bagikan/api/user_model.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:fe_bagikan/pages/PublicProfile.dart';
import 'package:fe_bagikan/pages/detailPost.dart';
import 'package:fe_bagikan/pages/editProfile.dart';
import 'package:fe_bagikan/pages/homepage.dart';
import 'package:fe_bagikan/pages/profile2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedBackPublicPage extends StatefulWidget {
  const FeedBackPublicPage({
    Key key,
    this.id,
  }) : super(key: key);

  final String id;

  @override
  _FeedBackPublicPageState createState() => _FeedBackPublicPageState();
}

class _FeedBackPublicPageState extends State<FeedBackPublicPage> {
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }

  String token;
  Profile profile;
  PublicProfile publicProfile;
  List<dynamic> listPost = [];
  PrivateProfilePost privateProfilePost;
  List<dynamic> listFeedBack = [];
  BuatFeedback buatFeedback;

  TextEditingController _feedBackController = TextEditingController();

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
        PrivateProfilePost.getPrivateProfilePost(token).then((value) {
          listPost = value;
          setState(() {
            print(listPost);
          });
        });
        FeedBackPrivate.getFeedBackPrivate(token, widget.id).then((value) {
          listFeedBack = value;
          setState(() {
            print(listFeedBack);
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
                        image: (publicProfile != null)
                            ? NetworkImage(
                                "http://192.168.100.46:8000/uploads/profilepicture/" +
                                    publicProfile.profilePicture)
                            : NetworkImage(
                                "https://nd.net/wp-content/uploads/2016/04/profile-dummy.png"))),
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

              Form(
                  child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffE1E1E1)),
                    child: TextFormField(
                      controller: _feedBackController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tulis Feedback",
                          hintStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                BuatFeedback.buatFeedback(token, widget.id,
                                        _feedBackController.text)
                                    .then((value) {
                                  buatFeedback = value;
                                  setState(() {
                                    print(buatFeedback);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FeedBackPublicPage(id: widget.id,)));
                                  });
                                });
                              });
                            },
                          )),
                    ),
                  ),
                ],
              )
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
                        profileImg:
                            "http://192.168.100.46:8000/uploads/profilepicture/"+revesedListFeedback[index].profilePictureSender,
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
