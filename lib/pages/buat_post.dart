import 'dart:convert';
import 'dart:io';
//import 'package:dropdownfield/dropdownfield.dart';
import 'package:fe_bagikan/api/buat_post_model.dart';
import 'package:fe_bagikan/api/user_model.dart';
import 'package:fe_bagikan/pages/homepage.dart';
import 'package:fe_bagikan/pages/timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart'; 
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';

class BuatPostPage extends StatefulWidget {
  @override
  _BuatPostPageState createState() => _BuatPostPageState();
}

class _BuatPostPageState extends State<BuatPostPage> {


Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }
  Dio dio = new Dio();
  String token;
  

  Profile profile;
  //BuatPost buatPost;

  final picker = ImagePicker();
  
  // String _picturePostPath;
  File _picturePost;

  Future pickImagePost() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    if (image != null) {
    File cropped = (await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: MediaQuery.of(context).size.width, ratioY: MediaQuery.of(context).size.width * 0.6),
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
        _picturePost = cropped;
    });}
  }

  @override
  void initState() {
    super.initState();
    getToken().then((s){
      token = s;
        print(token);
        Profile.getProfile(token).then((value) {
          profile = value; 
          if (mounted) {
            setState(() {
              print(profile.phone);
              });
          }
          });
      if(mounted){setState(() {});}
    });
  }

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

List<Expired> expired = [
  Expired("1 jam"),
  Expired("6 jam"),
  Expired("12 jam"),
  Expired("1 hari"),
  Expired("3 hari"),
  Expired("1 minggu"),
];

List<DropdownMenuItem> generateItemsExpired(List<Expired>expired){
  List<DropdownMenuItem> itemsExpired = [];
  for(var itemExpired in expired){
    itemsExpired.add(DropdownMenuItem(child: Text(itemExpired.expireds), value: itemExpired));
  }
  return itemsExpired;
}


  Kategori selectedKategori;
  Expired selectedExpired;

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
                        height: 50,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                        //   textStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                        //   hintText: "Kategori",
                        //   hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),
                        //   enabled: true,
                        //   itemsVisibleInDropdown: 3,
                        //   items: kategori,
                        //   onValueChanged: (value)
                        //   {
                        //     setState(() {
                        //       selectedKategori=value;
                        //     });
                        //   },
                        // ),
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
                        height: 50,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffE1E1E1),
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            hint: Text("Expired" , style: TextStyle(fontSize: 16),),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            value: selectedExpired,
                            items: generateItemsExpired(expired), 
                            onChanged: (itemExpired){
                              setState(() {
                                selectedExpired = itemExpired;
                                print(selectedExpired.expireds);
                              });
                            },
                          ),
                        // DropDownField(
                        //   controller: _expiredController,
                        //   textStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),
                        //   hintText: "Pilih waktu expired",
                        //   hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),
                        //   enabled: true,
                        //   itemsVisibleInDropdown: 3,
                        //   items: expired,
                        //   onValueChanged: (value)
                        //   {
                        //     setState(() {
                        //       selectedExpired=value;
                        //     });
                        //   },
                        // ),
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
                            pickImagePost();
                          }
                          ),
                        
                        
                            Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 200,
                            height: 120,
                            decoration: BoxDecoration(image: DecorationImage(image: (_picturePost != null) ? FileImage(_picturePost):NetworkImage("https://www.sercor.com.tr/wp-content/uploads/2019/04/23103.jpg"),fit: BoxFit.cover,)),
                            //NetworkImage(_picturePost);
                          ),


                      //button selesai
                      Container(
                        child:
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
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
                            showLoaderDialog(context);
                            if(_namaBarangController.text.isNotEmpty && _deskripsiBarangController.text.isNotEmpty && selectedKategori != null && _lokasiController.text.isNotEmpty && selectedExpired != null && _picturePost != null)
                            {
                                if (profile.phone != null) {
                                  if (selectedKategori.kategoris == "Umum" || selectedKategori.kategoris == "Rumah tangga" || selectedKategori.kategoris  == "Makanan") {
                                      if (selectedExpired.expireds == "1 jam" || selectedExpired.expireds == "6 jam" ||selectedExpired.expireds == "12 jam" ||selectedExpired.expireds == "1 hari" ||selectedExpired.expireds == "3 hari" ||selectedExpired.expireds == "1 minggu") {
                                        try {
                                            String token = await getToken();
                                            Map<String, dynamic> data = {};
                                        
                                            if (_picturePost!=null) {
                                              data["picture"] = await MultipartFile.fromFile(_picturePost.path, contentType: new MediaType("image", "jpeg"),);
                                              data["title"] = _namaBarangController.text;
                                              data["description"] = _deskripsiBarangController.text;
                                              data["location"] = _lokasiController.text;
                                              data["category"] = selectedKategori.kategoris;
                                              data["expired"] = selectedExpired.expireds;
                                            }
                                            
                                            Response res = await Dio().post("https://bagikan-backend.herokuapp.com/api/post/create",
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
                                                Navigator.pop(context);
                                                Alert(
                              context: context,
                              title: "Berhasil buat post",
                              type: AlertType.success,
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => {Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                builder: (context) => Homepage(tabIndex: 0)), (route)=>false)},
                                  width: 120,
                                )
                              ],
                            ).show();
                                                
                                              });
                                              
                                            }
                                          }
                                            catch (e){
                                              print(e);
                                            }
                                      }
                                      else{
                                        Navigator.pop(context);
                                        Alert(
                                          context: context,
                                          title: "Buat Post Gagal",
                                          desc:"Expired yang dimasukkan tidak sesuai",
                                          type: AlertType.error,
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 20),
                                              ),
                                              onPressed: () => Navigator.of(context).pop(),
                                              width: 120,
                                            )
                                          ],
                                        ).show();
                                      }
                                    }
                                  else{
                                    Navigator.pop(context);
                                    Alert(
                                  context: context,
                                  title: "Bust Post Gagal",
                                  desc:"Kategori yang dimasukkan tidak sesuai",
                                  type: AlertType.error,
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.of(context).pop(),
                                      width: 120,
                                    )
                                  ],
                                ).show();
                                }
                                }
                                else{
                                  Navigator.pop(context);
                                  Alert(
                                context: context,
                                title: "Buat Post Gagal",
                                desc:"Harap tambahkan nomor telepon pada profile",
                                type: AlertType.error,
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.of(context).pop(),
                                    width: 120,
                                  )
                                ],
                              ).show();
                              }
                            }
                            else
                            {
                              Navigator.pop(context);
                              Alert(
                              context: context,
                              title: "Buat Post Gagal",
                              desc:"Masih ada data yang kosong",
                              type: AlertType.error,
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                  width: 120,
                                )
                              ],
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
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 10),child:Text("Menunggu..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}

class Kategori{
  String kategoris;
  Kategori(this.kategoris);
}

class Expired{
  String expireds;
  Expired(this.expireds);
}