import 'package:flutter/material.dart';
import '../pages/game.dart';
import '../class/gameinfo.dart';

class Gamecard extends StatelessWidget {
  Gamecard({Key key, this.game, this.flexible = false}) : super(key: key);
  final GameInfo game;
  final bool flexible;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: double.maxFinite,
        child: Card(
            // margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Game(game: game)),
                );
              },
              child: Stack(overflow: Overflow.visible, children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Image.network(
                    game.imgUrl,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )),
                    // color: Colors.black38,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(game.gameTitle,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                          width: 100,
                          child: Text(game.gameDescription,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ]),
            ),
            elevation: 5));
  }
}
