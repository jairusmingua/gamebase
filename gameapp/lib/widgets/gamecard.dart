import 'package:flutter/material.dart';
import 'package:gameapp/class/game.dart';
import '../pages/gamepage.dart';


class Gamecard extends StatelessWidget {
  Gamecard({Key key, this.game, this.flexible = false,this.hasLabels=true}) : super(key: key);
  final Game game;
  final bool flexible;
  final bool hasLabels;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,

        child: Card(
            // margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/game",
                  arguments:game.gameId 
                );
              },
              child: Stack(overflow: Overflow.visible, children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Image.network(
                    game.imageUrl,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                (hasLabels?Positioned(
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
                ):Container()),
                (hasLabels?Positioned(
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
                          child: Text(game.gameTitle,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ):Container()),
              ]),
            ),
            elevation: 5));
  }
}
