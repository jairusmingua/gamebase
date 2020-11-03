import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gameapp/class/game.dart';
import 'package:gameapp/class/news.dart';
import 'package:gameapp/class/user.dart';
import 'package:gameapp/pages/gamepage.dart';
import 'package:gameapp/pages/newspage.dart';
import 'package:gameapp/services/storage.dart';
import 'package:gameapp/widgets/homeicon.dart';
import 'package:gameapp/widgets/loginmain.dart';
import 'package:gameapp/widgets/registermain.dart';
import 'package:gameapp/widgets/searchbar.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import '../widgets/gamecard.dart';
import 'login.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
// import 'game.dart';

class Home extends StatelessWidget {
  String initialRoute = "/home";
  @override
  Widget build(BuildContext context) {
    // User user = User(avatar:"https://firebasestorage.googleapis.com/v0/b/gamebase-f0578.appspot.com/o/001-panda%20bear.png?alt=media&token=8b14c2bd-770c-40e4-97af-ecd79412431a");
    return RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 10));
        },
        child: MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == GamePage.routeName) {
              final String gameId = settings.arguments;
              return MaterialPageRoute(builder: (context) {
                return GamePage(gameId: gameId);
              });
            }
          },
          initialRoute: "/home",
          routes: {
            "/home": (context) => HomeMain(),
            "/notice": (context) => Login(),
            "/login": (context) => LoginMain(
                  redirectToName: initialRoute,
                ),
            "/register": (context) =>
                RegisterMain(redirectToName: initialRoute),
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
                  color: Colors.white,
                ),
                bodyText2: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700, color: Colors.red[600]),
                subtitle1: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 12,
                ),
                headline1: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                headline2: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 25),
              )),
        ));
  }
}

class HomeMain extends StatefulWidget {
  HomeMain({this.showSearch = false});
  final bool showSearch;
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey(),
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
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
                  Row(children: [
                    RawMaterialButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => SearchOverlay()).then((value) {
                          if (value != null) {
                            Navigator.pushNamed(context, GamePage.routeName,
                                arguments: value);
                          }
                        });
                      },
                      child: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      constraints: BoxConstraints.expand(width: 50, height: 50),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    RawMaterialButton(
                      onPressed: () async {
                        String value = await getStorage("isLoggedIn");
                        print(value);
                        // Navigator.pushNamed(context,"/notice");
                        if (value == "true") {
                        } else {
                          Navigator.pushNamed(context, "/notice");
                        }
                      },
                      // elevation: 2.0,
                      constraints: BoxConstraints.expand(width: 50, height: 50),
                      // shape: BoxBorder(),
                      child: HomeIcon(),
                    ),
                  ]),
                ],
              ),
            ),
            Cardlist(title: "Top Games", apiroute: "/topgames"),
            Cardlist(title: "New Release", apiroute: "/newrelease"),
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

class SearchOverlay extends StatefulWidget {
  @override
  _SearchOverlayState createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  List<Game> results;
  bool isLoading = false;
  void _onSearch(String query) {
    setState(() {
      isLoading = true;
    });
    searchGame(query).then((value) {
      setState(() {
        results = value;
        isLoading = false;
      });
    });
  }

  void _onResultClick(String gameId) {
    Navigator.pop(this.context, gameId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        // color:Colors.black87,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            flexibleSpace: SearchBar(
              onChange: _onSearch,
            ),
          ),
          backgroundColor: Colors.black45,
          body: Container(
              child: isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : (results == null
                      ? Container()
                      : ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: ListTile(
                                  onTap: () {
                                    _onResultClick(results[index].gameId);
                                  },
                                  title: Text(
                                    results[index].gameTitle,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  )),
                            );
                          }))),
        ),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
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
                future: fetchGameList("game"+widget.apiroute),
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
            ],
          ),
        ),
      ],
    );
  }
}

class Newslist extends StatefulWidget {
  Newslist({Key key}) : super(key: key);

  @override
  _NewslistState createState() => _NewslistState();
}

class _NewslistState extends State<Newslist> {
  List<News>_news;

  @override
  void initState(){
    super.initState();
    fetchNews().then((value){
      setState((){
        _news = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_news==null){
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return Center(
        // padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
        child: CircularProgressIndicator()
      );
    }, childCount: 1));
    }    
    else{

    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return Container(
        padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
        child: Material(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
            child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  if(kIsWeb){
                    launch(_news[index].newsUrl);
                  }else{
                    Navigator.push(context,MaterialPageRoute(builder: (_){
                      return NewsPage(newsUrl: _news[index].newsUrl,);
                    }));
                  }
                },
                child: NewsTile(
                  news: _news[index],
                ))),
      );
    }, childCount: _news.length));
    }
  }
}

class NewsTile extends StatelessWidget {
  final News news;
  List<Color> colors =[
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.yellow[900],
    Colors.amber,
    Colors.pink,
    Colors.brown,
    Colors.cyan,
    Colors.teal,

  ];
  int randomColor;
  NewsTile({this.news}){
    randomColor = int.parse(news.articleTitle[0].codeUnitAt(0).toString()[1]);
  }


  @override
  Widget build(BuildContext context) {
    print(news.articleTitle[0]);
    print(int.parse(news.articleTitle[0].codeUnitAt(0).toString()[1]));
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      // width: 500,
      // color:Colors.black,
      
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
              flex: 9,
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(news.newsThumbnail))),
              )),
          Flexible(
            flex: 25,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Text(news.articleTitle,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
          ),
          Flexible(
            flex:1,
            fit:FlexFit.tight,
            child: Container(
              color: colors[randomColor]
            )
          ),
        ],
      ),
    );
  }
}
