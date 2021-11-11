import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fe_bagikan/api/edit_profile_model.dart';
import 'package:fe_bagikan/api/user_model.dart';
import 'package:fe_bagikan/constant/feed_back_json.dart';
import 'package:fe_bagikan/constant/post_json.dart';
import 'package:fe_bagikan/pages/homepage.dart';
import 'package:fe_bagikan/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }
  
  File _profilePicture;
  final picker = ImagePicker();

  Future pickImagePost() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    if (image != null) {
    File cropped = (await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 150, ratioY: 150), 
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.red,
            toolbarTitle: "Image Cropper",
            statusBarColor: Colors.red.shade900,
            backgroundColor: Colors.white,
          ))) as File;

      setState(() {
        _profilePicture = cropped;
    });}
  }

  String token;
  

  Profile profile;
  EditProfile editProfile;

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

  TextEditingController _namaUserController = TextEditingController();
  TextEditingController _bioUserController = TextEditingController();
  TextEditingController _nomorUserController = TextEditingController();

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
                          image: (_profilePicture != null) ? FileImage(_profilePicture): ((profile!=null)?NetworkImage(profile.profilePicture):NetworkImage("https://nd.net/wp-content/uploads/2016/04/profile-dummy.png"))
                        )
                      ),
                      ),
                      SizedBox(height: 15,),
                      GestureDetector(
                        child: Text("Ganti Foto Profile", style: TextStyle(color: Color(0xff1443C3), fontSize: 16, fontWeight: FontWeight.w700),),
                        onTap: (){
                          pickImagePost();
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
                              hintText: (profile!=null)?profile.nama:"Nama",
                              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
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
                              hintText: (profile!=null)?profile.deskripsi:"Bio",
                              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: (profile!=null)?profile.phone:"Nomor Tlp.",
                              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
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
                          onTap: () async {
                            if(_namaUserController.text.isNotEmpty || _bioUserController.text.isNotEmpty || _nomorUserController.text.isNotEmpty || _profilePicture!= null)
                            {
                              try {
                                  String token = await getToken();
                                  Map<String, dynamic> data = {};

                                  if (_profilePicture != null) {
                                    data["profilePicture"] = await MultipartFile.fromFile(_profilePicture.path, contentType: new MediaType("image", "jpeg"),);
                                  }
                                  if (_namaUserController.text.isNotEmpty) {
                                    data["name"] = await _namaUserController.text;
                                  }if (_bioUserController.text.isNotEmpty) {
                                    data["description"] = await _bioUserController.text;
                                  }if (_nomorUserController.text.isNotEmpty) {
                                    data["phone"] = await _nomorUserController.text;
                                  }
                                  
                                  Response res = await Dio().post("https://bagikan-backend.herokuapp.com/api/user/profile/update",
                                  data: FormData.fromMap(data),
                                  options: Options(headers: {
                                    "Authorization" : "Bearer $token",
                                    
                                  }),
                                  onSendProgress: (received, total){
                                    if(total != -1){
                                      print((received/total*100).toStringAsFixed(0) + "&");
                                    }
                                  },
                                  );
                                  print(json.decode(res.toString()));
                                  print(res.statusCode);
                                  if(res.statusCode == 201){
                                    setState(() {
                                      Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) => Homepage()), (route)=>false);
                                    });
                                    
                                  }
                                }
                                  catch (e){
                                    print(e);
                                  }
                            }
                            else
                            {
                              Alert(
                              context: context,
                              title: "Edit Gagal",
                              desc: "Data masih kosong",
                              type: AlertType.error,
                            ).show();
                              print("Data kosong");
                            }
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