

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
class Settings extends StatelessWidget {
  final _storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
                          children: [Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Settings",
                    style:GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w700,color: Theme.of(context).textTheme.headline1.color)
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape:BoxShape.circle,
                      image: DecorationImage(
                        fit:BoxFit.fill,
                        image: new NetworkImage('https://avatars3.githubusercontent.com/u/18586619?s=460&u=30a1c6ecfa750c3ea4b86bdbbdfc87556ecdd164&v=4'),
                      )
                    ),
                  ),
                  
                ],
              ),
              RaisedButton(onPressed: ()async{
                await _storage.write(key: "isLoggedIn", value: "false");
                await _storage.delete(key: "access_token");
              },child: Text("Logout"),)
              ]
            ),
          ),
          // Searchbar(),
     
         
        ],
    );
  }
}
