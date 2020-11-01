import 'package:flutter/material.dart';
import 'package:gameapp/class/user.dart';
import 'package:gameapp/services/storage.dart';
import 'package:gameapp/widgets/profileheader.dart';
import 'package:gameapp/widgets/reviewlist.dart';
import 'favoritelist.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User userinfo;
  bool isLoggedIn;
  // FlutterSecureStorage _storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getUser().then((User value) {
      print(value.avatar);
      setState(() {
        userinfo = value;
      });
    });
  }
  void refreshPage(){
    setState(() {
      userinfo=null;
    });
      getUser().then((User value) {
      print(value.avatar);
      setState(() {
        userinfo = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if (userinfo!=null){
      return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            centerTitle: true,
            // toolbarHeight: ,
            title: Text(
              '${userinfo.firstName.toString()} ${userinfo.lastName.toString()}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool isScrolled) {
                  return [
                    SliverAppBar(
                      collapsedHeight: 350,
                      expandedHeight: 350,
                      automaticallyImplyLeading: false,
                      backgroundColor: Theme.of(context).backgroundColor,
                      flexibleSpace: ProfileHeader(user: userinfo,onEditProfile:refreshPage),
                    ),
                    SliverPersistentHeader(
                        floating: true,
                        pinned: true,
                        delegate: TabDelegate(
                            tabBar: TabBar(
                          tabs: [
                            Tab(
                              text: "Favorites",
                            ),
                            Tab(
                              text: "Reviews",
                            )
                          ],
                          indicatorColor: Colors.red,
                        ))),
                  ];
                },
                body: TabBarView(
                  children: [FavoriteList(user: userinfo,), ReviewList(user: userinfo,)],
                )),
          ));
    }else{
      return Center(child:CircularProgressIndicator());
    }
  }
}

class TabDelegate extends SliverPersistentHeaderDelegate {
  TabDelegate({this.tabBar});
  final TabBar tabBar;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.black, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;
}
