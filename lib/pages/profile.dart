import 'package:fe_bagikan/api/private_profile_post.dart';
import 'package:fe_bagikan/api/public_profile_post.dart';
import 'package:fe_bagikan/api/user_model.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:fe_bagikan/pages/detailPost.dart';
import 'package:fe_bagikan/pages/editProfile.dart';
import 'package:fe_bagikan/pages/feedback_private_page.dart';
import 'package:fe_bagikan/pages/login_page.dart';
import 'package:fe_bagikan/pages/profile2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

    Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }
  
  String token;
  Profile profile;
  List<dynamic> listPost = [];
  PrivateProfilePost privateProfilePost;

  @override
  void initState() {
    super.initState();
    getToken().then((s){
      token = s;
      setState(() {
        print(token);
        Profile.getProfile(token).then((value) {
          profile = value; 
          setState(() {
            print(profile);
            });
          });
        PrivateProfilePost.getPrivateProfilePost(token).then((value) {
          listPost = value;
          setState(() {
            print(listPost);
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
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(accountName: Text((profile != null ) ? ((profile.nama != null ) ? profile.nama:"noname") : "noname"), accountEmail: Text(((profile!=null)?profile.email:"")),
              currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage((profile!=null)?profile.profilePicture:"https://nd.net/wp-content/uploads/2016/04/profile-dummy.png"),),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Edit Profile", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                onTap: (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                onTap: (){
                  Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()), (route)=>false);
                }
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
                        image: (profile!=null)?NetworkImage(profile.profilePicture):NetworkImage("https://nd.net/wp-content/uploads/2016/04/profile-dummy.png")
                      )
                    ),
                    ),
                    SizedBox(height: 10,),
                    Text((profile != null ) ? ((profile.nama != null ) ? profile.nama:"noname") : "noname"),
                    SizedBox(height: 10,),
                    Text((profile != null ) ? ((profile.deskripsi!= null ) ? profile.deskripsi:"Bio") : "Bio"),
                    SizedBox(height: 10,),
                    Container(
                        child:
                        GestureDetector(
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
                              style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                            )),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => FeedBackPrivatePage(id: profile.id)));
                          }
                          )),
                    SizedBox(height: 10,),
                    Container(height: 1, width: double.infinity ,color: Colors.black,),
                    SizedBox(height: 1,),
                    
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
                    var revesedListPost = List.of(listPost.reversed); 
                    return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        child: Image(
                          image: NetworkImage(revesedListPost[index].picture),
                          fit: BoxFit.cover,
                      )),
                      onTap: (){
                        setState(() {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => DetailPostPage(id :revesedListPost[index].id)));
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