import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gameapp/services/storage.dart';
import 'package:http/http.dart' as http;
import './game.dart';
class Review{
  final String reviewId;
  final String gameId;
  final String userId;
  final String username;
  final Game game;
  final String dateReview;
  final String reviewText;
  final String avatar;
  final int starRating;
  Review({this.reviewId,
  this.gameId,
  this.userId,
  this.dateReview,
  this.username,
  this.game,
  this.avatar,
  this.reviewText,
  this.starRating});

  factory Review.fromJson(Map<String,dynamic>json){
    return Review(
      reviewId: json["ReviewID"],
      gameId: json["GameID"],
      userId: json["UserID"],
      username: json["UserName"], 
      game: Game.fromJson(json["Game"]),
      reviewText: json["ReviewText"],
      starRating: json["StarRating"],
      dateReview:json["DateReview"],
      avatar:json["Avatar"]
    );
  }
}
List<Review> parseReviews(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Review>((json) => Review.fromJson(json)).toList();
}
Future<List<Review>> fetchReviewById(String id)async{
  
  
  Map<String,String> headers = {"Content-type": "application/json", "Accept": "application/json"};
  // token = "goWWORBtWQqeXXqjC179meFxiIvCuhchvOlDTuRMvccLo2NS6MOlXFg6iIaaiqk0hI0VI7tWAcyeO8LlzzTHB_r48uX2nzaQZKXcHKB1z6hJbvK-VqWKoSNIbpJYS-DuC6dyztCtwyohH5on5I5dlrIxLQW8HzBz1gtGCP-OhQwalRlKCSg36aR0Uh5ZyVkUV_Gbttnc06muHWIIoIIIMsL-llGWo4MiU79Wq4Gz7A-P6sNk6hWckkpYGEWFkmMl";
  final response = await http.get('https://gamebasebackend.azurewebsites.net/api/review/'+id, headers:headers);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseReviews,response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Games');
  } 
}
Future<Map<String,dynamic>> postReview(Map<String,dynamic>review,String gameId)async{
  var token = await getStorage("token");
  print(token);
  Map<String,String> headers ={"Content-type": "application/json", "Accept": "application/json","Authorization":"Bearer "+token};
  
  // token = "goWWORBtWQqeXXqjC179meFxiIvCuhchvOlDTuRMvccLo2NS6MOlXFg6iIaaiqk0hI0VI7tWAcyeO8LlzzTHB_r48uX2nzaQZKXcHKB1z6hJbvK-VqWKoSNIbpJYS-DuC6dyztCtwyohH5on5I5dlrIxLQW8HzBz1gtGCP-OhQwalRlKCSg36aR0Uh5ZyVkUV_Gbttnc06muHWIIoIIIMsL-llGWo4MiU79Wq4Gz7A-P6sNk6hWckkpYGEWFkmMl";
  //Map<String,String> headers = {"Content-type": "application/json", "Accept": "application/json"};
  // token = "goWWORBtWQqeXXqjC179meFxiIvCuhchvOlDTuRMvccLo2NS6MOlXFg6iIaaiqk0hI0VI7tWAcyeO8LlzzTHB_r48uX2nzaQZKXcHKB1z6hJbvK-VqWKoSNIbpJYS-DuC6dyztCtwyohH5on5I5dlrIxLQW8HzBz1gtGCP-OhQwalRlKCSg36aR0Uh5ZyVkUV_Gbttnc06muHWIIoIIIMsL-llGWo4MiU79Wq4Gz7A-P6sNk6hWckkpYGEWFkmMl";
  final response = await http.post('https://gamebasebackend.azurewebsites.net/api/review/'+gameId, 
  headers:headers,
  body:jsonEncode(review));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return {"success":true};
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw {"success":false};

  } 
}
Future<List<Review>> fetchUserReview(String userId)async{
  
  Map<String,String> headers ={"Content-type": "application/json", "Accept": "application/json"};
  
  // token = "goWWORBtWQqeXXqjC179meFxiIvCuhchvOlDTuRMvccLo2NS6MOlXFg6iIaaiqk0hI0VI7tWAcyeO8LlzzTHB_r48uX2nzaQZKXcHKB1z6hJbvK-VqWKoSNIbpJYS-DuC6dyztCtwyohH5on5I5dlrIxLQW8HzBz1gtGCP-OhQwalRlKCSg36aR0Uh5ZyVkUV_Gbttnc06muHWIIoIIIMsL-llGWo4MiU79Wq4Gz7A-P6sNk6hWckkpYGEWFkmMl";
  //Map<String,String> headers = {"Content-type": "application/json", "Accept": "application/json"};
  // token = "goWWORBtWQqeXXqjC179meFxiIvCuhchvOlDTuRMvccLo2NS6MOlXFg6iIaaiqk0hI0VI7tWAcyeO8LlzzTHB_r48uX2nzaQZKXcHKB1z6hJbvK-VqWKoSNIbpJYS-DuC6dyztCtwyohH5on5I5dlrIxLQW8HzBz1gtGCP-OhQwalRlKCSg36aR0Uh5ZyVkUV_Gbttnc06muHWIIoIIIMsL-llGWo4MiU79Wq4Gz7A-P6sNk6hWckkpYGEWFkmMl";
  final response = await http.get('https://gamebasebackend.azurewebsites.net/api/user/reviews/'+userId, headers:headers);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseReviews,response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Games');
  } 
}


//  {
//         "$id": "1",
//         "ReviewID": "eda06a86-04e0-490f-97cc-71ea7e8fa634",
//         "GameID": "c44023aa-7118-4729-8053-497952510e92",
//         "UserID": "36d09f3f-85e3-4097-873a-049d78368e4f",
//         "UserName": "jairusmingua",
//         "Game": {
//             "$id": "2",
//             "Favorites": [],
//             "Reviews": [],
//             "GameID": "c44023aa-7118-4729-8053-497952510e92",
//             "GameTitle": "PlayerUnkowns Battelgrounds",
//             "MatureRating": "Mature",
//             "Developer": "PUBG Corporation",
//             "Synopsis": "PlayerUnknowns Battlegrounds (PUBG) is an online multiplayer battle royale game developed and published by PUBG Corporation, a subsidiary of South Korean video game company Bluehole.",
//             "GameReleased": "2017-12-20T00:00:00",
//             "GameImageURL": "https://upload.wikimedia.org/wikipedia/en/thumb/3/3d/PlayerUnknown%27s_Battlegrounds_Steam_Logo.jpg/220px-PlayerUnknown%27s_Battlegrounds_Steam_Logo.jpg"
//         },
//         "ReviewText": "Must Play",
//         "StarRating": 3
//     },