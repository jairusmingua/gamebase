import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class User{
  User({this.firstName, this.lastName, this.userName, this.userId, this.favoriteCount, this.reviewCount, this.imgUrl});
  final String firstName;
  final String lastName;
  final String userName;
  final String userId;
  final String favoriteCount;
  final String reviewCount;
  final String imgUrl;

}
Future<Map<String,dynamic>> registerUser(Map<String,String>fields)async{
  final response = await http.post('https://gamebasebackend.azurewebsites.net/api/account/register',
  headers: <String,String>{
    "Accept":"application/json",
    "Content-Type":"application/x-www-form-urlencoded"
  },
  body:fields
  );
  if(response.statusCode==200){
    return {"registered":true};
  }else{
    Map<String,dynamic> errorMessage = Map.castFrom(jsonDecode(response.body));
    errorMessage["registred"] = false;
    return errorMessage;
  }
}
Future<Map<String,dynamic>> authenticateUser(Map<String,dynamic> fields)async{
  FlutterSecureStorage storage = FlutterSecureStorage();
  final response = await http.post(
        'https://gamebasebackend.azurewebsites.net/token',
        headers: <String, String>{
          "Content-type": "application/x-www-form-urlencoded",
          "Accept": "application/json"
        },
        body: <String, String>{
          "grant_type": "password",
          "username": fields["username"],
          "password": fields["password"]
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final parsed = jsonDecode(response.body);
      print(parsed);
      await storage.write(key: "token", value: parsed['access_token']);
      await storage.write(key: "isLoggedIn", value: "true");
      return Map.castFrom(jsonDecode(response.body));
    }else if(response.statusCode==400){
      throw Exception('Failed to load Games');
    }else{
      throw Exception('Failed to load Games');
    }
}