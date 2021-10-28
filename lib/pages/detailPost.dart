import 'package:fe_bagikan/constant/post_json.dart';
import 'package:fe_bagikan/helper/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailPostPage extends StatefulWidget {
  @override
  _DetailPostPageState createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {

  bool _isLiked = false;

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
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                    margin: EdgeInsets.only(left: 20, right: 15) ,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80")
                      )
                    ),
                    ),
                    Text("Riley lulululu", style: TextStyle(fontSize: 16),),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: SizeConfig.blockHorizontal * 100,
                  height: SizeConfig.blockHorizontal * 60,
                  child: Image(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
                      fit: BoxFit.cover,
                    ),
                  ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: IconButton(
                        icon: Icon(
                          _isLiked
                          ? Icons.favorite_outlined
                          : Icons.favorite_outline,
                          color: Colors.red,size: 30,
                        ),
                      onPressed: (){
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      ),
                    ),
                    Text("3 likes", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: 
                  Text(postsDummy[0]["deskripsi"])
                  ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: 
                  Text(postsDummy[0]["timeAgo"], style: TextStyle(fontSize: 9, color: Colors.grey),)
                  ), 
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: 
                  Text(postsDummy[0]["lokasi"],),
                  ), 

                  GestureDetector(
                    child: Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    height: 46,
                    width: 120,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff25D366),
                    ),
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: FaIcon(
                              FontAwesomeIcons.whatsapp, color: Colors.white,
                              ),
                          ),
                          Text(
                          "Hubungi",
                          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                      ),
                    ),
                    onTap: () {
                    
                    }
                    ),
        
            ],
            ),
            ),
        )
        
    );
  }
}