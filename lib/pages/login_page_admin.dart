import 'package:fe_bagikan/api/post_model.dart';
import 'package:fe_bagikan/api/user_model.dart';
import 'package:fe_bagikan/pages/dashboard_admin/adminDashobard.dart';
import 'package:fe_bagikan/pages/homepage.dart';
import 'package:fe_bagikan/pages/login_page.dart';
import 'package:fe_bagikan/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

bool _passwordVisible = false;

void initState() {
  _passwordVisible = true;
}

class _AdminLoginPageState extends State<AdminLoginPage> {

  String token;
  LoginResult loginResult;
  AdminLoginResult adminLoginResult;

  final formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  bool _btnEnabled = false;

  void saveData() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', adminLoginResult.token);  
    
  }
  Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/login.png",
                width: SizeConfig.blockHorizontal * 100,
                height: SizeConfig.blockVertical * 35,
              ),
              SizedBox(height: 10),
              Text(
                "Login as Admin Now",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 12),
              Text(
                "Please enter the details below to continue",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 23),

              //Form username password
              Form(
                  key: formKey,
                  onChanged: () => setState(
                      () => _btnEnabled = formKey.currentState.validate()),
                  child: Column(
                    children: <Widget>[
                      //Username
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffE1E1E1)),
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukkan Username",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),

                      //Password
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffE1E1E1),
                        ),
                        child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukkan Password",
                              hintStyle: TextStyle(fontSize: 14),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(0xffC4C4C4)),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                color: Color(0xffC4C4C4),
                              ),
                            )),
                      ),
                    ],
                  )),
              SizedBox(height: 90),
              GestureDetector(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xff1443C3),
                    ),
                    child: Center(
                        child: Text(
                      "Login",
                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
                    )),
                  ),
                  onTap: () {
                    showLoaderDialog(context);
                    if(_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty)
                    {
                      AdminLoginResult.adminLogin(_usernameController.text, _passwordController.text).then((value) {
                      adminLoginResult = value;
                        if(adminLoginResult.token == null){
                          Navigator.pop(context);
                          Alert(
                          context: context,
                          title: "Login Gagal",
                          desc: "Email atau password yang anda masukkan salah",
                          type: AlertType.error,
                        ).show();
                          print("Data yang dimasukkan salah");
                        }
                        else {
                          Navigator.pop(context);
                          print(adminLoginResult.token);
                          saveData();
                          getToken().then((s){
                            token = s;
                            if (mounted) {
                              setState(() {});
                            }
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPage()), (route)=>false);
                      }
                    }
                    );        
                    }
                    else{
                      Navigator.pop(context);
                      Alert(
                          context: context,
                          title: "Login Gagal",
                          desc: "Masih ada data yang kosong",
                          type: AlertType.error,
                        ).show();
                      print(Text("data masih ada yang kosong"));
                    }
                    if(mounted){setState(() {
                      
                    });}
                    
                  }),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login as user? ",
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    child: Text(
                      "Here",
                      style: TextStyle(fontSize: 14, color: Color(0xff1443C3)),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
                    },
                  ),
                ],
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
