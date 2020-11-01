import 'package:flutter/material.dart';
import 'package:gameapp/class/avatars.dart';
import 'package:gameapp/pages/editpage.dart';
import '../class/user.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({this.user,this.isGuest =false, this.onEditProfile});
  final User user;
  final bool isGuest;
  final Function()onEditProfile;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: new NetworkImage(convertAvatarToUrl(user.avatar)),
              )),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(user.userName,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ),
        isGuest==false?RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, EditPage.routeName,arguments: user).then((value){
              onEditProfile();
              print(value);
            });

          },
          color: Colors.black,
          child: Text("Edit Profile", style: TextStyle(color: Colors.white)),
        ):Container(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Text(user.favoriteCount.toString()),
                Text(
                  "Favorites",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ]),
              Column(children: [
                Text(user.reviewCount.toString()),
                Text(
                  "Reviews",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ])
            ],
          ),
        )
      ],
    );
  }
}
