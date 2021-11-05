import 'package:fe_bagikan/api/admin/delete_user_admin.dart';
import 'package:fe_bagikan/api/admin/get_user_admin.dart';
import 'package:fe_bagikan/pages/dashboard_admin/adminDashobard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminUser extends StatefulWidget {
  @override
  _AdminUserState createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }

  String token;
  User user;
  List<dynamic> listUser = [];

  @override
  void initState() {
    super.initState();
    getToken().then((s) {
      token = s;
      setState(() {
        print(token);
        User.getUser(token).then((value) {
          listUser = value;
          setState(() {
            print(listUser);
          });
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: List.generate((listUser != []) ? listUser.length : 0, (index) {
            if (listUser != []){
              var revesedListUser = List.of(listUser.reversed);

              return Users(
                id: revesedListUser[index].id,
                username: revesedListUser[index].username,
                email: revesedListUser[index].email,
              );
            }
            
          })

        
        )
        
        
      ),
    );
  }
}

class Users extends StatefulWidget {
  const Users({
    Key key, this.id, this.username, this.email, this.token,
  }) : super(key: key);
  
  final String id;
  final String username;
  final String email;
  final String token;

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {

  DeleteUser deleteUser;

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
                    DeleteUser.deleteUser(widget.token, widget.id).then((value) {
                      deleteUser = value;
                      setState(() {
                        print(deleteUser.message);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                            builder: (context) => AdminPage()));
                      });
                    });
                  },
                  child: Text("Delete"))
            ],
          ),
        ),
      ],
    );
  }
}
