import 'package:flutter/material.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/class/user.dart';
import 'package:gameapp/widgets/gamecard.dart';
class FavoriteList extends StatefulWidget {
  FavoriteList({this.user});
  final User user;
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // GameList game = new GameList();
    // getToken();
    return FutureBuilder(
        future: fetchUserFavorites(widget.user.userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 271 / 377),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Gamecard(game: snapshot.data[index]);
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
