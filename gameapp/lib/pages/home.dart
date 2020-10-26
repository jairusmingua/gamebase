import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/class/user.dart';
import '../class/gamelist.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/gamecard.dart';
import 'login.dart';
// import 'game.dart';

class Home extends StatelessWidget {
  final _storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    User user = User(imgUrl:"https://firebasestorage.googleapis.com/v0/b/gamebase-f0578.appspot.com/o/001-panda%20bear.png?alt=media&token=8b14c2bd-770c-40e4-97af-ecd79412431a");
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 10));
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.fromLTRB(12, 40, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "gamebase",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color:
                                Theme.of(context).textTheme.headline1.color)),
                  ),
                  RawMaterialButton(
                    onPressed: ()async {
                      String value = await _storage.read(key: "isLoggedIn");
                      print(value);
                        // Navigator.pushNamed(context,"/notice");
                      if(value=="true"){
                        
                        
                      }else{
                        Navigator.pushNamed(context,"/notice");

                      }
                    },
                    // elevation: 2.0,  
                    constraints: BoxConstraints.expand(width: 50,height:50),
                    // shape: BoxBorder(),
                    child: Container(
                      height: 50,
                      width: 50,
                      
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                               user.imgUrl),
                          )),
                        
                    ),
                  ),
                ],
              ),
            ),
            Cardlist(title: "Top Games", apiroute: "/topgames"),
            Cardlist(title: "Top Grossing", apiroute: "/grossing"),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              alignment: Alignment.topLeft,
              child: Text(
                "News",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).textTheme.bodyText1.color)),
              ),
            ),
          ])),
          Newslist(),
        ],
      ),
    );
  }
}

class Cardlist extends StatefulWidget {
  Cardlist({
    Key key,
    this.title,
    this.apiroute,
  }) : super(key: key);
  final String title;
  final String apiroute;
  @override
  _CardlistState createState() => _CardlistState();
}

class _CardlistState extends State<Cardlist> {
  Future<List<Game>> futureGame;
  @override
  void initState() {
    super.initState();
    futureGame = fetchGameList("game/topgames");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).textTheme.bodyText1.color)),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 9, 0, 9),
          height: 250,
          child: Stack(
            children: <Widget>[
              FutureBuilder<List<Game>>(
                future: fetchGameList("game/topgames"),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Gamecard(game: snapshot.data[index]);
                          })
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),

              // Positioned(
              //   right: 0,
              //   bottom: 0,
              //   top: 0,
              //   child: IgnorePointer(
              //     child: Container(
              //       width: 300,
              //       decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //               colors: [Colors.transparent, Theme.of(context).backgroundColor],
              //               begin: Alignment.center,
              //               end: Alignment(1, 0),
              //               tileMode: TileMode.clamp)),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class Newslist extends StatelessWidget {
  Newslist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 2;
    GameList game = new GameList();
    MediaQueryData query;
    query = MediaQuery.of(context);
    int ratio = 274;
    if (((query.size.width.toInt() ~/ ratio) + 1) > 7) {
      count = 7;
    } else if (((query.size.width.toInt() ~/ ratio) + 1) < 2) {
      count = 2;
    } else {
      count = (query.size.width.toInt() ~/ ratio) + 1;
    }
    print((query.size.width.toInt() ~/ ratio) + 1);
    print(count);
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count,
        // mainAxisSpacing: 1,
        // crossAxisSpacing: 5,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Gamecard(game: game.Games[index]);
        },
        childCount: game.Games.length,
      ),
    );
  }
}
