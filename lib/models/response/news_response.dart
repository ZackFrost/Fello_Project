///Created by Ian Paul on 2-08-2021 00:35
import 'dart:convert';
import 'package:fello_demo_app/models/news.dart';

NewsResponse newsResponseFromJson(String str) => NewsResponse.fromJson(json.decode(str));

String newsResponseToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
  NewsResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  String? status;
  int? totalResults;
  List<News>? articles;

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<News>.from(json["articles"]?.map((x) => News.fromJson(x)) ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles?.map((x) => x.toJson()) ?? {}),
  };
}
