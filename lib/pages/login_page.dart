import 'package:fe_bagikan/api/post_model.dart';
import 'package:fe_bagikan/pages/homepage.dart';
import 'package:fe_bagikan/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

bool _passwordVisible = false;

void initState() {
  _passwordVisible = true;
}

class _LoginPageState extends State<LoginPage> {

  LoginResult loginResult;

  final formKey = GlobalKey<FormState>();

  String _email, _password;

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
                "Login Now",
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
                          borderRadius: BorderRadius.circular(15),
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
                    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty)
                    {
                      LoginResult.login(_emailController.text, _passwordController.text).then((input) {
                      loginResult = input;
                      setState(() {
                        if(loginResult == null){
                          Alert(
                          context: context,
                          title: "Login Gagal",
                          desc: "Email atau password yang anda masukkan salah",
                          type: AlertType.error,
                        ).show();
                          print(Text("Data yang dimasukkan salah"));
                        }
                        else{
                          print(loginResult.massage);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));
                        }
                      });
                    }
                    );        
                    }
                    else{
                      print(Text("data masih ada yang kosong"));
                    }
                    
                  }),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 14, color: Color(0xff1443C3)),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
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
