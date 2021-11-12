import 'dart:io';

import 'package:fe_bagikan/api/admin/delete_post_admin.dart';
import 'package:fe_bagikan/api/get_post_detail.dart';
import 'package:fe_bagikan/api/like_post.dart';
import 'package:fe_bagikan/constant/post_json.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:fe_bagikan/pages/editPost.dart';
import 'package:fe_bagikan/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailPostPage extends StatefulWidget {
  const DetailPostPage({
    Key key,
    bool isLiked,
    this.id,
  }) : super(key: key);

  final String id;
  @override
  _DetailPostPageState createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  String token;
  bool _isLiked = false;

  PostDetail postDetail;
  String like;
  LikePost likePost;
  DislikePost dislikePost;
  GetLike getLike;
  DeletePost deletePost;


  void initState() {
    super.initState();
    getToken().then((s) {
      token = s;
        print(token);
        PostDetail.getPostDetail(token, widget.id).then((value) {
          postDetail = value;
          if (mounted) {
            setState(() {
              print(postDetail);
            });
          }
        });
        GetLike.getGetLike(token, widget.id).then((value) {
          getLike = value;
          print(getLike);
          if (mounted) {
            setState(() {
              if (getLike != null) {
                if (getLike.statusLike == "true") {
                  _isLiked = true;
                }
              } else {
                _isLiked = false;
              }
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 15),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage((postDetail != null)
                                  ? (postDetail.profilePicture)
                                  : ("https://nd.net/wp-content/uploads/2016/04/profile-dummy.png")))),
                    ),
                    Text(
                      (postDetail != null) ? postDetail.username : "",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: FaIcon(
                          FontAwesomeIcons.ellipsisV,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      onTap: () {
                        _tripEditModalBottomSheet(context);
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: SizeConfig.blockHorizontal * 100,
                  height: SizeConfig.blockHorizontal * 60,
                  child: Image(
                    image: NetworkImage((postDetail != null)
                        ? (postDetail.picture)
                        : "https://nd.net/wp-content/uploads/2016/04/profile-dummy.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: IconButton(
                        icon: Icon(
                          _isLiked
                              ? Icons.favorite_outlined
                              : Icons.favorite_outline,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                            if (getLike != null) {
                              print(getLike.statusLike);
                              if (getLike.statusLike == "true") {
                                DislikePost.dislikePost(token, widget.id)
                                    .then((value) {
                                  dislikePost = value;
                                  if (mounted) {
                                    setState(() {
                                      _isLiked = false;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPostPage(id: widget.id)));
                                    });
                                  }
                                });
                              } else if (getLike.statusLike == "false") {
                                LikePost.likePost(token, widget.id)
                                    .then((value) {
                                  likePost = value;
                                  if (mounted) {
                                    setState(() {
                                      _isLiked = true;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPostPage(id: widget.id)));
                                    });
                                  }
                                });
                              }
                            }
                          if(mounted){setState(() {});}
                        },
                      ),
                    ),
                    Text(
                      ((postDetail != null) ? postDetail.like : "0") + " likes",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text((postDetail != null) ? postDetail.title : "",
                        style: TextStyle(fontWeight: FontWeight.w600))),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                        (postDetail != null) ? postDetail.description : "")),
                Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: _timeAgo()
                    // Text(postsDummy[0]["timeAgo"], style: TextStyle(fontSize: 9, color: Colors.grey),)
                    ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Text((postDetail != null) ? postDetail.location : ""),
                ),
              ],
            ),
          ),
        ));
  }

  _timeAgo() {
    if (postDetail != null) {
      String time = postDetail.createdAt;
      DateTime dateTime = DateTime.parse(postDetail.createdAt);
      var formatedTanggal =
          new DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
      timeago.setLocaleMessages('id', timeago.IdMessages());

      return Text(timeago.format(DateTime.parse(time), locale: 'id'),
          style: TextStyle(fontSize: 9, color: Colors.grey));
    }
  }

  void _tripEditModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: SizeConfig.blockVertical * 15,
            padding: EdgeInsets.all(10),
            color: Colors.black87,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "Edit Post",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                      Spacer(),
                      Container(
                        margin:
                            EdgeInsets.only(left: 10, right: 10, bottom: 15),
                        child: FaIcon(
                          FontAwesomeIcons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditPostPage(id: widget.id)));
                    });
                  },
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      Text("Delete Post",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 16),
                        child: FaIcon(
                          FontAwesomeIcons.trash,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    DeletePost.deletePost(token, widget.id).then((value) {
                      deletePost = value;
                      setState(() {
                        print(deletePost.message);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                            builder: (context) => Homepage()));
                      });
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}
