import 'package:flutter/material.dart';
import 'package:gameapp/class/avatars.dart';
import 'package:gameapp/class/user.dart';

class HomeIcon extends StatefulWidget {
  @override
  _HomeIconState createState() => _HomeIconState();
}

class _HomeIconState extends State<HomeIcon> {
  
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: getUser(),
          builder:(context,AsyncSnapshot<User>snapshot){
            if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? Container(
                      height: 50,
                      width: 50,
                      
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                               convertAvatarToUrl(snapshot.data.avatar)),
                          )),
                        
                      )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
          },
          
    );
  }
}
