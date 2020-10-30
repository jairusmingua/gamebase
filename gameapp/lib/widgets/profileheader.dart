import 'package:flutter/material.dart';
import 'package:gameapp/class/avatars.dart';
import '../class/user.dart';
class ProfileHeader extends StatelessWidget {
  ProfileHeader({this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
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
