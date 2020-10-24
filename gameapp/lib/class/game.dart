import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;

class Game{
  final String gameId;
  final String gameTitle;
  final String imageUrl;
  final String matureRating;
  final String releaseDate;
  final String synopsis;
  final bool isFavorite;
  Game({this.gameId,this.gameTitle,this.imageUrl,this.matureRating,this.releaseDate,this.synopsis,this.isFavorite});
  
  factory Game.fromJson(Map<String,dynamic>json){
    return Game(
      gameId: json["GameID"],
      gameTitle: json["GameTitle"],
      imageUrl: json["GameImageURL"],
      matureRating: json["MatureRating"],
      releaseDate: json["GameReleased"],
      synopsis: json["Synopsis"],
      isFavorite:json["isFavorite"]
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

Future<List<Game>> fetchUserFavorites()async{
  // Map <String,String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};
  FlutterSecureStorage _storage = FlutterSecureStorage();
  var token = await _storage.read(key:"token");
  print(token);
  // token = "goWWORBtWQqeXXqjC179meFxiIvCuhchvOlDTuRMvccLo2NS6MOlXFg6iIaaiqk0hI0VI7tWAcyeO8LlzzTHB_r48uX2nzaQZKXcHKB1z6hJbvK-VqWKoSNIbpJYS-DuC6dyztCtwyohH5on5I5dlrIxLQW8HzBz1gtGCP-OhQwalRlKCSg36aR0Uh5ZyVkUV_Gbttnc06muHWIIoIIIMsL-llGWo4MiU79Wq4Gz7A-P6sNk6hWckkpYGEWFkmMl";
  final response = await http.get('https://gamebasebackend.azurewebsites.net/api/game/favorites',headers:<String,String>{"Content-type": "application/json", "Accept": "application/json","Authorization":"Bearer "+token} );
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

Future<Null> favoriteGameById(String id)async{
  FlutterSecureStorage _storage = FlutterSecureStorage();
  var token = await _storage.read(key:"token");
  final response = await http.post('https://gamebasebackend.azurewebsites.net/api/game/favorite/'+id,headers:<String,String>{"Content-type": "application/json", "Accept": "application/json","Authorization":"Bearer "+token} );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Games');
  } 
}
Future<Null> unfavoriteGameById(String id)async{
  FlutterSecureStorage _storage = FlutterSecureStorage();
  var token = await _storage.read(key:"token");
  final response = await http.delete('https://gamebasebackend.azurewebsites.net/api/game/favorite/'+id,headers:<String,String>{"Content-type": "application/json", "Accept": "application/json","Authorization":"Bearer "+token} );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Games');
  } 
}
Future<Game> fetchGameById(String id)async{
  // Map <String,String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};
  
  FlutterSecureStorage _storage = FlutterSecureStorage();
  var t = await _storage.read(key: "token");
  print(t);
  Map<String,String> headers = (t !=""|| t!= null)?{"Content-type": "application/json", "Accept": "application/json","Authorization":"Bearer "+t}:{"Content-type": "application/json", "Accept": "application/json"};
  // token = "goWWORBtWQqeXXqjC179meFxiIvCuhchvOlDTuRMvccLo2NS6MOlXFg6iIaaiqk0hI0VI7tWAcyeO8LlzzTHB_r48uX2nzaQZKXcHKB1z6hJbvK-VqWKoSNIbpJYS-DuC6dyztCtwyohH5on5I5dlrIxLQW8HzBz1gtGCP-OhQwalRlKCSg36aR0Uh5ZyVkUV_Gbttnc06muHWIIoIIIMsL-llGWo4MiU79Wq4Gz7A-P6sNk6hWckkpYGEWFkmMl";
  final response = await http.get('https://gamebasebackend.azurewebsites.net/api/game/'+id, headers:headers);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Game.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Games');
  } 
}