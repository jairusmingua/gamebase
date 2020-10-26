import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
String params = "alt=media&token=8b14c2bd-770c-40e4-97af-ecd79412431aalt=media&token=8b14c2bd-770c-40e4-97af-ecd79412431a";

class Avatar{
    Avatar({this.name,this.bucket});
    final String name;
    final String bucket;
    factory Avatar.fromJson(Map<String,dynamic>json){
      return Avatar(
        name: json["name"],
        bucket:json["bucket"]
      );
    }
}
List<Avatar> parseAvatar(String responseBody){
   final parsed = Map.castFrom(jsonDecode(responseBody));
  
  
  return parsed["items"].map<Avatar>((json)=>Avatar.fromJson(json)).toList();
}
Future<List<Avatar>>fetchAvatars()async{
   
  final response = await http.get("https://firebasestorage.googleapis.com/v0/b/gamebase-f0578.appspot.com/o/",headers:<String,String>{"Accept": "application/json"} );
  if(response.statusCode==200){
    return compute(parseAvatar,response.body);
  }else{
    throw "Cannot load images";
  }
}
String convertAvatarToUrl(String name){
  String url = "https://firebasestorage.googleapis.com/v0/b/gamebase-f0578.appspot.com/o/"+name+"?"+params;
  return Uri.encodeFull(url);
}