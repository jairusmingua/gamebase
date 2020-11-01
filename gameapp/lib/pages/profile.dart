import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gameapp/class/avatars.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/class/gameinfo.dart';
import 'package:gameapp/class/review.dart';
import 'package:gameapp/class/user.dart';
import 'package:gameapp/pages/editpage.dart';
import 'package:gameapp/services/storage.dart';
import 'package:gameapp/widgets/loginmain.dart';
import 'package:gameapp/widgets/registermain.dart';
import 'package:gameapp/widgets/userprofile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gamepage.dart';
import 'home.dart';
import '../widgets/gamecard.dart';
import '../class/gamelist.dart';

import 'login.dart';
import 'settings.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController controller;
  User userinfo;
  bool isLoggedIn;
  String initialRoute="/userprofile";
  // FlutterSecureStorage _storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getStorage("isLoggedIn").then((value) {
      if (value == "false" || value == null) {
        setState(() {
          isLoggedIn = false;
        });
      } else {
        setState((){
          isLoggedIn = true;
        });
      }
    });
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return MaterialApp(
        onGenerateRoute: (settings) {
            if (settings.name == GamePage.routeName) {
              final String gameId = settings.arguments;
              return MaterialPageRoute(builder: (context) {
                return GamePage(gameId: gameId);
              });
            }else if(settings.name == EditPage.routeName){
              final User user = settings.arguments;
              return MaterialPageRoute(builder:(context){
                return EditPage(user:user);
              });
            }
          },
          initialRoute: isLoggedIn == true ? "/userprofile" : "/notice",
          routes: {
            "/userprofile": (context) => UserProfile(),
            "/notice": (context) => Login(),
            "/login": (context) => LoginMain(redirectToName: initialRoute,),
            "/register": (context) => RegisterMain(redirectToName:initialRoute),
          },
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
      );
    }
  }
}

class ReviewCards extends StatelessWidget {
  ReviewCards({this.review});
  final Review review;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.all(5),
      color: Theme.of(context).backgroundColor,
      child: Row(
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Gamecard(
                game: review.game,
                hasLabels: false,
              )),
          Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(review.game.gameTitle),
                      ),
                      Text(
                        review.reviewText,
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.clip,
                      ),
                    ]),
              )),
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                // color:Colors.yellow,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        Icon(
                          Icons.star,
                          size: 40,
                          color: Colors.yellow,
                        ),
                        Text(review.starRating.toString() + "/5")
                      ]),
                    ]),
              ))
        ],
      ),
    );
  }
}
