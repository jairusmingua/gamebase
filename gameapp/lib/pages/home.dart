import 'package:flutter/material.dart';
import '../class/gamelist.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/gamecard.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            padding: EdgeInsets.fromLTRB(12, 40, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Games",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).textTheme.headline1.color)),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            'https://avatars3.githubusercontent.com/u/18586619?s=460&u=30a1c6ecfa750c3ea4b86bdbbdfc87556ecdd164&v=4'),
                      )),
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
        // Searchbar(),
        Newslist(),
        // LayoutBuilder(
        //   builder: (context,constraint){
        //       if(constraint.maxWidth>600){
        //         return Newslist();
        //       }else{
        //         return Newslist(count: 5,);
        //       }

        //   },
        // )
        // Cardlist(title: "Trending", apiroute: "/trending"),
      ],
    );
  }
}

class Cardlist extends StatelessWidget {
  Cardlist({
    Key key,
    this.title,
    this.apiroute,
  }) : super(key: key);
  final String title;
  final String apiroute;
  @override
  Widget build(BuildContext context) {
    GameList gamelist = new GameList();
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          alignment: Alignment.topLeft,
          child: Text(
            title,
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
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: gamelist.Games.length,
                  itemBuilder: (context, index) {
                    return Gamecard(game: gamelist.Games[index]);
                  }),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: IgnorePointer(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Theme.of(context).backgroundColor],
                            begin: Alignment.center,
                            end: Alignment(1, 0),
                            tileMode: TileMode.clamp)),
                  ),
                ),
              ),
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
    int count =2;
    GameList game = new GameList();
    MediaQueryData query; 
    query = MediaQuery.of(context);
    int ratio = 274;
    if(((query.size.width.toInt()~/ratio)+1)>7){
      count = 7;
    }else if(((query.size.width.toInt()~/ratio)+1)<2){
      count =2;
    }else{
      count = (query.size.width.toInt()~/ratio)+1;
    }
    print((query.size.width.toInt()~/ratio)+1);
    print(count);
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:count,
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
