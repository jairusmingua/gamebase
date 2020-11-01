import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gameapp/class/user.dart';
import 'package:gameapp/widgets/txtbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginMain extends StatefulWidget {
  const LoginMain({Key key, this.redirectToName}) : super(key: key);
  final String redirectToName;
  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  String username;
  String password;
  bool hasError = false;
  bool isLoading = false;
  final storage = FlutterSecureStorage();
  void _changeUsername(String _username) {
    setState(() {
      username = _username;
    });
  }

  void _changePassword(String _password) {
    setState(() {
      password = _password;
      hasError=false;
    });
  }

  void authenticate() async {
    setState(() => isLoading = true);
    Map<String, dynamic> fields = {"username": username, "password": password};
    authenticateUser(fields).then((value) {
      setState(() => isLoading = false);
      Navigator.popAndPushNamed(context, widget.redirectToName);
    }).catchError((onError) {
      setState(() {
        isLoading = false;
        hasError= true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
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
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
          child: Container(
            alignment: Alignment.topLeft,
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Text(
                    "gamebase",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  TxtBox(
                    placeholder: "Username",
                    onChanged: _changeUsername,
                  ),
                  TxtBox(
                    placeholder: "Password",
                    onChanged: _changePassword,
                    isPassword: true,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  hasError?Text("Incorrect Username or Password"):Container(),
                  Padding(padding: EdgeInsets.symmetric(vertical: 40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        color: Colors.black,
                        onPressed: authenticate,
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
                        padding: const EdgeInsets.only(right: 20),
                        child:
                            isLoading ? CircularProgressIndicator() : Center(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
