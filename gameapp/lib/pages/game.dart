import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../class/gameinfo.dart';
class Game extends StatelessWidget {
  Game({Key key, this.game}) : super(key: key);
  final GameInfo game;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: 400,
                  child: AspectRatio(
                    aspectRatio: 271 / 377,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                game.imgUrl),
                          )),
                    ),
                  ),
                ),
                Text(
                  game.gameTitle,
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                ),
                Padding(padding: EdgeInsets.only(bottom:20)),
                Text(
                  game.gameStory,
                  style: GoogleFonts.montserrat(
                  textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
