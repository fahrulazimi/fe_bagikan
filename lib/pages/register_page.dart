import 'package:fe_bagikan/api/post_model.dart';
import 'package:fe_bagikan/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

bool _passwordVisible = false;

void initState() {
  _passwordVisible = true;
}

class _RegisterPageState extends State<RegisterPage> {
  PostResult postResult = null;

  final formKey = GlobalKey<FormState>();

  String _username, _password, _email;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _btnEnabled = false;

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
                "Register Now",
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
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffE1E1E1)),
                        child: TextFormField(
                          controller: _usernameController,
                          onSaved: (input) => _username = input,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukkan Username",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),
                      //Email
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffE1E1E1)),
                        child: TextFormField(
                          controller: _emailController,
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukkan Email",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),
                      //Password
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffE1E1E1),
                        ),
                        child: TextFormField(
                            controller: _passwordController,
                            onSaved: (input) => _password = input,
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
              SizedBox(height: 22),
              GestureDetector(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xff1443C3),
                    ),
                    child: Center(
                        child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                  onTap: () {
                    if(_usernameController.text.isNotEmpty && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty)
                    {
                      PostResult.connectToAPI(_usernameController.text, _emailController.text, _passwordController.text).then((input) {
                      postResult = input;
                      setState(() {
                        print("register");
                        if(postResult.message != "User stored successfully!")
                        {
                          Alert(
                              context: context,
                              title: "Register Gagal",
                              desc:
                                  "username atau email sudah digunakan",
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
                        else{
                          Alert(
                              context: context,
                              title: "Register Berhasil",
                              type: AlertType.success,
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
                          Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (route) => false);
                        }
                      });
                    }
                    );
                    }
                    else{
                      print(Text("data masih ada yang kosong"));
                      Alert(
                              context: context,
                              title: "Register Gagal",
                              desc:
                                  "Masih ada data yang belum diisi",
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
                  }),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 14, color: Color(0xff1443C3)),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
