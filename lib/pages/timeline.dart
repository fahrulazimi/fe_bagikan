import 'package:fe_bagikan/api/get_all_post.dart';
import 'package:fe_bagikan/api/like_post.dart';
import 'package:fe_bagikan/constant/post_json.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:fe_bagikan/pages/PublicProfile.dart';
import 'package:fe_bagikan/pages/detailPost.dart';
import 'package:fe_bagikan/pages/detailPostPublic.dart';
import 'package:fe_bagikan/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }

  String token;
  bool _isLiked;
  Posts posts;
  List<dynamic> listPost = [];

  @override
  void initState() {
    super.initState();
    getToken().then((s) {
      token = s;
      setState(() {
        print(token);
        Posts.getPosts(token).then((posts) {
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

  var reversedPostsDummy = List.of(postsDummy.reversed);

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
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
            ),
            Column(
              children: List.generate((listPost != []) ? listPost.length : 0,
                  (index) {
                if (listPost != []) {
                  var revesedListPost = List.of(listPost.reversed);
                  String time = revesedListPost[index].createdAt;
                  DateTime dateTime = DateTime.parse(time);
                  var formatedTanggal =
                      new DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
                  timeago.setLocaleMessages('id', timeago.IdMessages());

                  return TimelinePosts(
                    name: revesedListPost[index].username,
                    title: revesedListPost[index].title,
                    profileImg: "http://192.168.100.46:8000/uploads/profilepicture/" +
                        revesedListPost[index].profilePicture,
                    postImg: "http://192.168.100.46:8000/uploads/post/" +
                        revesedListPost[index].picture,
                    deskripsi: revesedListPost[index].description,
                    timeAgo: timeago.format(DateTime.parse(time), locale: 'id'),
                    lokasi: revesedListPost[index].location,
                    likes: revesedListPost[index].like,
                    userId: revesedListPost[index].userId,
                    id: revesedListPost[index].id,
                    token: token,
                  );
                }
              }),
            )
          ],
        ));
  }
}

class TimelinePosts extends StatefulWidget {
  const TimelinePosts({
    Key key,
    bool isLiked,
    this.profileImg,
    this.postImg,
    this.deskripsi,
    this.timeAgo,
    this.lokasi,
    this.name,
    this.likes,
    this.userId,
    this.title,
    this.id,
    this.token,
  }) : super(key: key);

  final String name;
  final String profileImg;
  final String postImg;
  final String deskripsi;
  final String timeAgo;
  final String lokasi;
  final String likes;
  final String userId;
  final String title;
  final String id;
  final String token;

  @override
  State<TimelinePosts> createState() => _TimelinePostsState();
}

class _TimelinePostsState extends State<TimelinePosts> {
  bool _isLiked = false;
  LikePost likePost;
  DislikePost dislikePost;
  GetLike getLike;

  @override
  void initState() {
    GetLike.getGetLike(widget.token, widget.id).then((value) {
      getLike = value;
      print(getLike);
      setState(() {
        if (getLike != null) {
      if (getLike.statusLike == "true") {
        _isLiked = true;
      }
    } else {
      _isLiked = false;
    }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, right: 15),
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
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PublicProfilePage(
                          id: widget.userId,
                        )));
          },
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: SizeConfig.blockHorizontal * 100,
          height: SizeConfig.blockHorizontal * 60,
          child: Image(
            image: NetworkImage(widget.postImg),
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite_outlined : Icons.favorite_outline,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    if(getLike!=null){
                      print(getLike.statusLike);
                    if (getLike.statusLike == "true") {
                      DislikePost.dislikePost(widget.token, widget.id)
                          .then((value) {
                        dislikePost = value;
                        setState(() {
                          _isLiked = false;
                          Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage()));
                        });
                      });
                    } else if(getLike.statusLike == "false") {
                      LikePost.likePost(widget.token, widget.id).then((value) {
                        likePost = value;
                        setState(() {
                          _isLiked = true;
                          Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage()));
                        });
                      });
                    }
                    }
                    
                  });
                },
              ),
            ),
            Text(
              widget.likes + " likes",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            )),
        Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(widget.deskripsi)),
        Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: GestureDetector(
              child: Text(
                "Lihat Selengkapnya...",
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPostPublicPage(id: widget.id)));
                });
              },
            )),
        Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              widget.timeAgo,
              style: TextStyle(fontSize: 9, color: Colors.grey),
            )),
      ],
    );
  }
}
