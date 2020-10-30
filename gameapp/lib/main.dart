import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gameapp/pages/login.dart';
import 'package:gameapp/services/storage.dart';
import 'package:gameapp/widgets/loginmain.dart';
import 'package:gameapp/widgets/registermain.dart';
import 'package:google_fonts/google_fonts.dart';
//pages
import './pages/dashboard.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {

  runApp(MyApp());

  
}

class MyApp extends StatelessWidget {

  final storage = FlutterSecureStorage();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        backgroundColor: Colors.grey[900],
        primaryColor: Colors.red[600],
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            color:Colors.white,
          ),
          bodyText2: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            color:Colors.red[600]
          ),
          subtitle1: GoogleFonts.lato(
            color:Colors.white,
            fontSize: 12,
          ),
          headline1:GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            color:Colors.white,
          ), 
          headline2:GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            color:Colors.white,
            fontSize: 25
          ), 
        )
      ),
      // home: Game(title: 'FarCry:Primal'),
      home: Dashboard(title: 'Dashboard'),
      
      
    );
  }
}

