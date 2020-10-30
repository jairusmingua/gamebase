import 'package:flutter/material.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/pages/login.dart';
import 'package:gameapp/services/storage.dart';

class FavoriteIcon extends StatefulWidget {
  FavoriteIcon({this.game});
  final Game game;
  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  Icon _icon;
  void onFavorite() {
    getStorage("isLoggedIn").then((value){
      if(value=="true"){
        if (_icon.color == Colors.white) {
          favoriteGameById(widget.game.gameId).then((value) => setState(() {
                _icon = Icon(
                  Icons.favorite,
                  color: Colors.red,
                );
              }));
        } else {
          unfavoriteGameById(widget.game.gameId).then((value) => setState(() {
                _icon = Icon(
                  Icons.favorite,
                  color: Colors.white,
                );
              }));
        }

      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.game.isFavorite);
    _icon = widget.game.isFavorite == false || widget.game.isFavorite  ==null
        ? Icon(
            Icons.favorite,
            color: Colors.white,
          )
        : Icon(
            Icons.favorite,
            color: Colors.red,
          );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _icon,
      iconSize: 30,
      onPressed: () {
        onFavorite();
      },
    );
  }
}
