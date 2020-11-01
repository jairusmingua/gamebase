import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../services/storage.dart';

class User {
  User(
      {this.firstName = "",
      this.userId,
      this.lastName = "",
      this.userName = "",
      this.favoriteCount = 0,
      this.reviewCount = 0,
      this.avatar = "002-dog.png"});
  final String firstName;
  final String lastName;
  final String userName;
  final String userId;
  final int favoriteCount;
  final int reviewCount;
  final String avatar;
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json["FirstName"],
        lastName: json["LastName"],
        userName: json["UserName"],
        favoriteCount: json["FavoriteCount"],
        reviewCount: json["ReviewCount"],
        avatar: json["Avatar"],
        userId: json["UserId"]);
  }
}

Future<Map<String, dynamic>> registerUser(Map<String, String> fields) async {
  final response = await http.post(
      'https://gamebasebackend.azurewebsites.net/api/account/register',
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: fields);
  if (response.statusCode == 200) {
    return {"registered": true};
  } else {
    Map<String, dynamic> errorMessage = Map.castFrom(jsonDecode(response.body));
    errorMessage["registred"] = false;
    return errorMessage;
  }
}

Future<String> changePassword(Map<String, String> fields) async {
  final token = await getStorage("token");
  print(token);
  final response = await http.post(
      'https://gamebasebackend.azurewebsites.net/api/account/password',
      headers: <String, String>{
        "Content-type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      },
      body: jsonEncode(fields));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return null;
  } else if (response.statusCode == 400) {
    return "Incorrect Password";
  }
  return "Error";
}

Future<Map<String, dynamic>> authenticateUser(
    Map<String, dynamic> fields) async {
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
    await storeStorage("token", parsed['access_token']);
    await storeStorage("isLoggedIn", "true");
    return Map.castFrom(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    throw Exception('Failed to load Games');
  } else {
    throw Exception('Failed to load Games');
  }
}

Future<User> getUser() async {
  final isLoggedIn = await getStorage("isLoggedIn");
  if (isLoggedIn == "true") {
    final token = await getStorage("token");

    final response = await http.get(
        'https://gamebasebackend.azurewebsites.net/api/user',
        headers: <String, String>{
          "Content-type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer " + token
        });

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  } else {
    return User(avatar: "002-dog.png");
  }
}

Future<User> getUserById(String id) async {
  //   Map<String,String> headers = (token !=null)?{"Content-type": "application/json", "Accept": "application/json","Authorization":"Bearer "+token}:{"Content-type": "application/json", "Accept": "application/json"};
  final response = await http.get(
      'https://gamebasebackend.azurewebsites.net/api/user/' + id,
      headers: <String, String>{
        "Content-type": "application/json",
        "Accept": "application/json"
      });

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

Future<String> changeProfile(Map<String, String> fields) async {
  final token = await getStorage("token");
  final avatarChangeResponse = await http.post(
    'https://gamebasebackend.azurewebsites.net/api/account/avatar?avatar=' +
        Uri.encodeComponent(fields["avatar"]),
    headers: <String, String>{
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    },
  );
  if (avatarChangeResponse.statusCode == 200) {
    final nameChangeResponse = await http.post(
      'https://gamebasebackend.azurewebsites.net/api/account/name',
      headers: <String, String>{
        "Content-type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      },
      body: jsonEncode(fields)
    );
    if(nameChangeResponse.statusCode==200){
      return "success";
    }else{
      throw "Network Error";
    }
  }else{
    throw "Network Error";
  }
}
