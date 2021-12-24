import 'package:fe_bagikan/api/admin/delete_post_admin.dart';
import 'package:fe_bagikan/api/admin/get_post_admin.dart';
import 'package:fe_bagikan/api/admin/get_user_admin.dart';
import 'package:fe_bagikan/pages/dashboard_admin/adminDashobard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPost extends StatefulWidget {
  @override
  _AdminPostState createState() => _AdminPostState();
}

class _AdminPostState extends State<AdminPost> {

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  String token;
  Post post;
  List<dynamic> listPost = [];

  @override
  void initState() {
    super.initState();
    getToken().then((s) {
      token = s;
        print(token);
        Post.getPost(token).then((value) {
          listPost = value;
          if (mounted) {
            setState(() {
              print(listPost);
            });
          }
        });
      if(mounted){setState(() {});}
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: List.generate((listPost != []) ? listPost.length : 0, (index) {
            if (listPost != []){
              var revesedListPost = List.of(listPost.reversed);

              return Posts(
                id: revesedListPost[index].id,
                username: revesedListPost[index].title,
                email: revesedListPost[index].description,
                token: token,
              );
            }
            
          })

        
        )
        
        
      ),
    );
  }
}



class Posts extends StatefulWidget {
  const Posts({
    Key key, this.id, this.username, this.email, this.token,
  }) : super(key: key);
  
  final String id;
  final String username;
  final String email;
  final String token;

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  DeletePost deletePost;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.username),
                  Container(
                    width: 240,
                    child: Text(
                      widget.email,
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff1443C3),
                  ),
                  onPressed: () {
                    showAlertDialog(context);
                    // DeletePost.deletePost(widget.token, widget.id).then((value) {
                    //   deletePost = value;
                    //   setState(() {
                    //     print(deletePost.message);
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //         builder: (context) => AdminPage()));
                    //   });
                    // });
                  },
                  child: Text("Delete"))
            ],
          ),
        ),
      ],
    );
  }
  void showAlertDialog(BuildContext context) {  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Kembali"),
    onPressed:  () {Navigator.of(context).pop();},
  );
  Widget continueButton = FlatButton(
    child: Text("Hapus"),
    onPressed:  () {
      DeletePost.deletePost(widget.token, widget.id).then((value) {
                      deletePost = value;
                      setState(() {
                        print(deletePost.message);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                            builder: (context) => AdminPage()),
                            (route) => false);
                      });
                    });
    },
  );  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Hapus Post"),
    content: Text("Anda yakin ingin hapus?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
}
