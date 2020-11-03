
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gameapp/class/game.dart';
import 'package:intl/intl.dart';
import '../class/game.dart';

class GamePageHeader extends StatelessWidget {
  GamePageHeader({this.game});
  final Game game;
  @override
  Widget build(BuildContext context) {
    DateFormat formatter = new DateFormat('yMMMMd');
    DateFormat yearFormater = new DateFormat('y');
    String date = formatter.format(DateTime.parse(game.releaseDate));
    String year = yearFormater.format(DateTime.parse(game.releaseDate));
    return Container(
      child: Stack(children: [
        Positioned.fill(
          // width: double.infinity,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX:20,sigmaY:20),
            child: Image.network(
              game.imageUrl, 
              fit: BoxFit.fitWidth
              )),
        ),
        Positioned.fill(
          child:Container(
            color: Colors.black54,
          )
        ),
        // Positioned(
        //   child: ClipRect(
        //     child: BackdropFilter(
        //       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        //       child: Container(
        //         height: double.infinity,
        //         color: Colors.black54,
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
            // color: Colors.black38,
          ),
        ),
        Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Container(
                  height: 200,
                  child: AspectRatio(
                    aspectRatio: 123 / 171,
                    child: Image.network(game.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        year,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(color: Colors.grey),
                          child: Text(
                            game.matureRating,
                            style: Theme.of(context).textTheme.subtitle1,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.yellow,
                        ),
                        Text('${game.starRating}')
                      ]),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    game.gameTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 100,
                    child: Text(
                      game.synopsis,
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(children: [
                    Row(children: [
                      Text(
                        "Release Date: ",
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        date,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                    ]),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(children: [
                    Row(children: [
                      Text(
                        "Developer: ",
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        game.developer,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                    ]),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
