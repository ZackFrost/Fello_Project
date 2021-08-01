///Created by Ian Paul on 2-08-2021 00:32
import 'package:fello_demo_app/constants.dart';
import 'package:fello_demo_app/models/response/news_response.dart';
import 'package:fello_demo_app/utils/network_utils.dart';
import 'package:http/http.dart' as http;

class NewsService{

 Future<NewsResponse> fetchNews({required int pageNo, required int pageSize}) async{
  String url = "https://newsapi.org/v2/top-headlines?country=in&page=$pageNo&pageSize=$pageSize&apiKey=$API_KEY";
  http.Response _response =  await NetworkUtils.createGetRequest(url);
  return newsResponseFromJson(_response.body);
 }
}