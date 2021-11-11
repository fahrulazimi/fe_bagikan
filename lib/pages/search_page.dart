import 'dart:convert';
import 'dart:io';
//import 'package:dropdownfield/dropdownfield.dart';
import 'package:fe_bagikan/api/buat_post_model.dart';
import 'package:fe_bagikan/api/like_post.dart';
import 'package:fe_bagikan/api/search.dart';
import 'package:fe_bagikan/api/user_model.dart';
import 'package:fe_bagikan/pages/homepage.dart';
import 'package:fe_bagikan/pages/timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'PublicProfile.dart';
import 'detailPostPublic.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }

  String token;
  bool _kategoriIsON = false;
  bool _lokasiIsON = false;

  Profile profile;
  Widget kategoriWidget = SizedBox(
    height: 1,
  );
  Widget lokasiWidget = SizedBox(
    height: 1,
  );

  List<dynamic> listPost = [];
  @override
  void initState() {
    super.initState();
    getToken().then((s) {
      token = s;
      setState(() {
        print(token);
      });
    });
  }

  @override
  
  List<Kategori> kategori = [
  Kategori("Umum"),
  Kategori("Rumah tangga"),
  Kategori("Makanan"),
];

List<DropdownMenuItem> generateItemsKategori(List<Kategori>kategori){
  List<DropdownMenuItem> itemsKategori = [];
  for(var itemKategori in kategori){
    itemsKategori.add(DropdownMenuItem(child: Text(itemKategori.kategoris), value: itemKategori));
  }
  return itemsKategori;
}

  Kategori selectedKategori;

  TextEditingController _namaBarangController = TextEditingController();
  TextEditingController _deskripsiBarangController = TextEditingController();
  TextEditingController _kategoriController = TextEditingController();
  TextEditingController _lokasiController = TextEditingController();
  TextEditingController _expiredController = TextEditingController();
  TextEditingController _picturePostController = TextEditingController();

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
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  "Search Post",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffE1E1E1)),
                    child: TextFormField(
                      controller: _namaBarangController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Cari Barang",
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10, right: 5),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Berdasarkan kategori",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Spacer(),
                        Switch(
                            activeColor: Color(0xff1443C3),
                            value: _kategoriIsON,
                            onChanged: (newValue) {
                              _kategoriIsON = newValue;
                              setState(() {
                                if (_kategoriIsON) {
                                  kategoriWidget = Container(
                                    height: 50,
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    margin: EdgeInsets.fromLTRB(20, 5, 20, 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xffE1E1E1),
                                    ),
                                    child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text("Kategori" , style: TextStyle(fontSize: 16),),
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                    value: selectedKategori,
                                    items: generateItemsKategori(kategori), 
                                    onChanged: (itemKategori){
                                      setState(() {
                                        selectedKategori = itemKategori;
                                      });
                                    },
                                  ),
                                    // DropDownField(
                                    //   controller: _kategoriController,
                                    //   textStyle: TextStyle(
                                    //       fontWeight: FontWeight.normal,
                                    //       fontSize: 14),
                                    //   hintText: "Pilih kategori",
                                    //   hintStyle: TextStyle(
                                    //       fontSize: 14,
                                    //       fontWeight: FontWeight.normal),
                                    //   enabled: true,
                                    //   itemsVisibleInDropdown: 3,
                                    //   items: kategori,
                                    //   onValueChanged: (value) {
                                    //     setState(() {
                                    //       selectedKategori = value;
                                    //     });
                                    //   },
                                    // ),
                                  );
                                } else {
                                  kategoriWidget = SizedBox(
                                    height: 1,
                                  );
                                  selectedKategori.kategoris = "";
                                }
                              });
                            })
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10, right: 5),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Berdasarkan lokasi",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Spacer(),
                        Switch(
                            activeColor: Color(0xff1443C3),
                            value: _lokasiIsON,
                            onChanged: (newValue) {
                              _lokasiIsON = newValue;
                              setState(() {
                                if (_lokasiIsON) {
                                  lokasiWidget = Container(
                                    padding: EdgeInsets.only(left: 15),
                                    margin: EdgeInsets.fromLTRB(20, 5, 20, 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xffE1E1E1),
                                    ),
                                    child: TextFormField(
                                      controller: _lokasiController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Masukkan lokasi",
                                        hintStyle: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  );
                                } else {
                                  lokasiWidget = SizedBox(
                                    height: 1,
                                  );
                                  _lokasiController.text="";
                                }
                              });
                            })
                      ],
                    ),
                  ),

                  AnimatedSwitcher(
                    child: kategoriWidget,
                    duration: Duration(milliseconds: 500),
                  ),
                  AnimatedSwitcher(
                    child: lokasiWidget,
                    duration: Duration(milliseconds: 500),
                  ),

                  //button selesai
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            height: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xff1443C3),
                            ),
                            child: Center(
                                child: Text(
                              "Cari",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                          ),
                          onTap: () {
                            Search.getSearch(
                                    token,
                                    _namaBarangController.text,
                                    selectedKategori.kategoris,
                                    _lokasiController.text)
                                .then((posts) {
                              listPost = posts;
                              setState(() {
                                print(posts.length);
                                print(listPost);
                                print(listPost[0].title);
                              });
                            });
                          })),

                  Container(
                    width: SizeConfig.blockHorizontal * 100,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                            (listPost != []) ? listPost.length : 0, (index) {
                          if (listPost != []) {
                            var revesedListPost = List.of(listPost.reversed);
                            String time = revesedListPost[index].createdAt;
                            DateTime dateTime = DateTime.parse(time);
                            var formatedTanggal =
                                new DateFormat('yyyy-MM-dd hh:mm:ss')
                                    .format(dateTime);
                            timeago.setLocaleMessages(
                                'id', timeago.IdMessages());

                            return TimelinePosts(
                              name: revesedListPost[index].username,
                              title: revesedListPost[index].title,
                              profileImg:
                                  revesedListPost[index].profilePicture,
                              postImg:
                                  revesedListPost[index].picture,
                              deskripsi: revesedListPost[index].description,
                              timeAgo: timeago.format(DateTime.parse(time),
                                  locale: 'id'),
                              lokasi: revesedListPost[index].location,
                              likes: revesedListPost[index].like,
                              userId: revesedListPost[index].userId,
                              id: revesedListPost[index].id,
                              token: token,
                            );
                          }
                          else{
                              return NoPost();
                            
                          }
                        }),
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class NoPost extends StatelessWidget {
  const NoPost({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Tidak ada post yang sesuai"),
      ],
    );
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
        Container(

            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(top: 10),
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



class Kategori{
  String kategoris;
  Kategori(this.kategoris);
}
