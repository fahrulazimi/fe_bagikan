import 'package:fe_bagikan/constant/feed_back_json.dart';
import 'package:fe_bagikan/constant/post_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  bool _passwordVisible = false;

  void initState(){
    _passwordVisible = true;
  }

  TextEditingController _namaUserController = TextEditingController();
  TextEditingController _bioUserController = TextEditingController();
  TextEditingController _nomorUserController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile"),),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
                padding: EdgeInsets.all(20),
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
                      SizedBox(height: 15,),
                      GestureDetector(
                        child: Text("Ganti Foto Profile", style: TextStyle(color: Color(0xff1443C3), fontSize: 16, fontWeight: FontWeight.w700),),
                        onTap: (){

                        },
                      ),
                      SizedBox(height: 20,),

                      Form(
                        child: Column(
                    children: <Widget>[
                      //Nama 
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text("Nama", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffE1E1E1)),
                        child: TextFormField(
                          controller: _namaUserController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nama",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),

                      //Bio
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text("Bio", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffE1E1E1)),
                        child: TextFormField(
                          controller: _bioUserController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Bio",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),

                      //nomor tlp

                      Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text("Nomor Tlp.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffE1E1E1)),
                        child: TextFormField(
                          controller: _nomorUserController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nomor Tlp.",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),

                      //email
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffE1E1E1)),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),

                      //button selesai
                      Container(
                        child:
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            height: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xff1443C3),
                            ),
                            child: Center(
                                child: Text(
                              "Selesai",
                              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
                            )),
                          ),
                          onTap: () {
                            
                          }
                          )
                          ),

                      ]
                      ),
                      )
                  ],
                  ),
          ),
        ),
        ), 
    );
  }
}