import 'package:fe_bagikan/api/get_all_post.dart';
import 'package:fe_bagikan/constant/post_json.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {

  Future<String> getToken() async{
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
    getToken().then((s){
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
        title:Row(
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
                )
              ),
            ),
            Text("Bagikan", style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
        ),
        body:  ListView(
          children: <Widget>[
            Container(
            margin: EdgeInsets.only(bottom: 10),),
            Column(
              children: List.generate((listPost!=[])?listPost.length:0, (index){
                if(listPost!=[]){
                return TimelinePosts(
                  name: "a",//reversedPostsDummy[index]["name"],
                  profileImg: reversedPostsDummy[index]["profileImg"],
                  postImg: reversedPostsDummy[index]["postImg"],
                  deskripsi: listPost[index].description,
                  timeAgo: "a",//reversedPostsDummy[index]["timeAgo"],
                  lokasi: "a",//reversedPostsDummy[index]["lokasi"],
                  likes: listPost[index].like,
                );}
              }
              ),
            )
          ],
          )
        );
    
  }
}

class TimelinePosts extends StatefulWidget {
  const TimelinePosts({
    Key key,
    bool isLiked, this.profileImg, this.postImg, this.deskripsi, this.timeAgo, this.lokasi, this.name, this.likes,
  }) : super(key: key);

  final String name;
  final String profileImg;
  final String postImg;
  final String deskripsi;
  final String timeAgo;
  final String lokasi;
  final String likes;

  @override
  State<TimelinePosts> createState() => _TimelinePostsState();
}

class _TimelinePostsState extends State<TimelinePosts> {

  bool _isLiked = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
            margin: EdgeInsets.only(left: 20, right: 15) ,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                widget.profileImg)
              )
            ),
            ),
            Text(widget.name, style: TextStyle(fontSize: 16),),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: SizeConfig.blockHorizontal * 100,
          height: SizeConfig.blockHorizontal * 60,
          child: Image(
            image: NetworkImage(
              widget.postImg),
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
                  color: Colors.red,size: 30,
                ),
              onPressed: (){
                setState(() {
                  _isLiked = !_isLiked;
                });
              },
              ),
            ),
            Text(widget.likes + " likes", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
          ],
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: 
          Text(widget.deskripsi)
          ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: 
          Text(widget.timeAgo, style: TextStyle(fontSize: 9, color: Colors.grey),)
          ), 
      ],);
  }
}