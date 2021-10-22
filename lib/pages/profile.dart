import 'package:fe_bagikan/api/user_model.dart';
import 'package:fe_bagikan/pages/editProfile.dart';
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              UserAccountsDrawerHeader(accountName: Text((profile!=null)?profile.nama:""), accountEmail: Text((profile!=null)?profile.email:""),
              currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage((profile!=null)?profile.profilePicture:""),),
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
                leading: Icon(Icons.comment),
                title: Text("Feedback", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                onTap: (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile2Page()));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
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
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80")
                      )
                    ),
                    ),
                    SizedBox(height: 10,),
                    Text((profile!=null)?profile.nama:""),
                    SizedBox(height: 10,),
                    Text((profile!=null)?profile.deskripsi:""),
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