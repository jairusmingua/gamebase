import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gameapp/widgets/loginmain.dart';
import 'package:gameapp/widgets/registermain.dart';
import 'package:google_fonts/google_fonts.dart';

// class Login extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Theme.of(context).backgroundColor,
//       resizeToAvoidBottomPadding: false,
     
//     );
//   }
// }

class Login extends StatelessWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.black,
        
      ),
      resizeToAvoidBottomPadding: false,
      body: Stack(children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              'images/gamebg.webp',
              fit: BoxFit.cover,
            )),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black87,
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Engage with community. Share your favorites",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).textScaleFactor*20,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RaisedButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/login");
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Login",
                          style: GoogleFonts.montserrat(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    RaisedButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/register");
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Register",
                          style: GoogleFonts.montserrat(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}




