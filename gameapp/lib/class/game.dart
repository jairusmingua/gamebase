import 'dart:convert';

import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

class Game{
  final int gameId;
  final String gameTitle;
  final String imageUrl;
  final String matureRating;
  final String releasedDate;
  final String synopsis;

  Game({this.gameId,this.gameTitle,this.imageUrl,this.matureRating,this.releasedDate,this.synopsis});

  factory Game.fromJson(Map<String,dynamic>json){
    return Game(
      gameId: json["GameId"],
      gameTitle: json["GameTitle"],
      imageUrl: json["ImageUrl"],
      matureRating: json["MatureRating"],
      releasedDate: json["ReleasedDate"],
      synopsis: json["Synopsis"]
    );
  }
}
List<Game> parseGame(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Game>((json) => Game.fromJson(json)).toList();
}

Future<List<Game>> fetchGameList(String route)async{
  // Map <String,String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};
  final response = await http.get('https://gamebasebackend.azurewebsites.net/api/game/topgames',headers:<String,String>{"Content-type": "application/json", "Accept": "application/json"} );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseGame,response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Games');
  } 
}