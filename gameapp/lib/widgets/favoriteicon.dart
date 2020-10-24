import 'package:flutter/material.dart';
import 'package:gameapp/class/game.dart';

class FavoriteIcon extends StatefulWidget {
  FavoriteIcon({this.game});
  final Game game;
  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  Icon _icon;
  void onFavorite() {
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
  }

  @override
  void initState() {
    super.initState();
    print(widget.game.isFavorite);
    _icon = widget.game.isFavorite == false
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
