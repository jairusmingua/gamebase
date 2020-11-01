import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class News{
  final String newsId;
  final String newsUrl;
  final String articleTitle;
  final String newsThumbnail;
  News({this.newsId,this.newsUrl,this.articleTitle,this.newsThumbnail});

  factory News.fromJson(Map<String,dynamic>json){
      return News(
        newsId: json["NewsID"],
        newsUrl: json["NewsURL"],
        articleTitle: json["ArticleTitle"],
        newsThumbnail: json["NewsThumbnail"]
      );
  }

}


List<News> parseNews(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<News>((json) => News.fromJson(json)).toList();
}


Future<List<News>> fetchNews()async{
  final response = await http.get('https://gamebasebackend.azurewebsites.net/api/news',headers:<String,String>{"Content-type": "application/json", "Accept": "application/json"} );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseNews,response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Games');
  } 
}