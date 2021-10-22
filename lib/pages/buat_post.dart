import 'package:dropdownfield/dropdownfield.dart';
import 'package:fe_bagikan/api/buat_post_model.dart';
import 'package:fe_bagikan/api/user_model.dart';
import 'package:fe_bagikan/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuatPostPage extends StatefulWidget {
  @override
  _BuatPostPageState createState() => _BuatPostPageState();
}

class _BuatPostPageState extends State<BuatPostPage> {


Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }
  
  String token;
  

  Profile profile;
  BuatPost buatPost;

  @override
  void buatPostBaru() {
    getToken().then((s){
      token = s;
      setState(() {
        print(token);
        BuatPost.buatPost(token, _namaBarangController.text, _deskripsiBarangController.text, _lokasiController.text, _kategoriController.text, _expiredController.text, _picturePostController.text).then((value) {
          buatPost = value;
          setState(() {
            print(buatPost);
            print(buatPost.message);
            if(buatPost.message == "Post stored successfully!")
            {  
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
              builder: (context) => Homepage()), (route)=>false);
            }
            });
        });
      });
    });
  }

List<String> kategori = [
  "Umum",
  "Rumah tangga",
  "Makanan"
];

List<String> expired = [
  "1 jam",
  "12 jam",
  "24 jam"
];

  String selectedKategori = "";
  String selectedExpired = "";

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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  "Buat Post",
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
                      //Nama Barang
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text("Nama Barang", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffE1E1E1)),
                        child: TextFormField(
                          controller: _namaBarangController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nama Barang",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),

                      //Deskripsi Barang
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text("Deskripsi Barang", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffE1E1E1),
                        ),
                        child: TextFormField(
                            controller: _deskripsiBarangController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Deskripsi Barang",
                              hintStyle: TextStyle(fontSize: 14),                              ),
                        ),
                      ),

                      //kategori
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text("Kategori", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffE1E1E1),
                        ),
                        child: DropDownField(
                          controller: _kategoriController,
                          textStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                          hintText: "Kategori",
                          hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),
                          enabled: true,
                          itemsVisibleInDropdown: 3,
                          items: kategori,
                          onValueChanged: (value)
                          {
                            setState(() {
                              selectedKategori=value;
                            });
                          },
                        ),
                      ),

                      //lokasi
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text("Lokasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffE1E1E1),
                        ),
                        child: TextFormField(
                            controller: _lokasiController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Lokasi",
                              hintStyle: TextStyle(fontSize: 14),                              ),
                        ),
                      ),

                      //expired
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text("Expired", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffE1E1E1),
                        ),
                        child: DropDownField(
                          controller: _expiredController,
                          textStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),
                          hintText: "Expired",
                          hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),
                          enabled: true,
                          itemsVisibleInDropdown: 3,
                          items: expired,
                          onValueChanged: (value)
                          {
                            setState(() {
                              selectedExpired=value;
                            });
                          },
                        ),
                      ),


                      //uploadGambar
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.topLeft,
                        child: Text("Upload Gambar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            height: 46,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xff1443C3),
                            ),
                            child: Center(
                                child: Text(
                              "Upload",
                              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
                            )),
                          ),
                          onTap: () {
                            
                          }
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
                            print(_kategoriController.text);
                            if(_namaBarangController.text.isNotEmpty && _deskripsiBarangController.text.isNotEmpty)
                            {
                              buatPostBaru();
                            }
                            else
                            {
                              Alert(
                              context: context,
                              title: "Buat post Gagal",
                              desc: "Masih ada data yang kosong",
                              type: AlertType.error,
                            ).show();
                              print("Masih ada data kosong");
                            }
                            
                          }
                          )
                          ),
                            ],
                          )
                          ),
            ],
          ),
        ),
      ),
    );
  }
}
