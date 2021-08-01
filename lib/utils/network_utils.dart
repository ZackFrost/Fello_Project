///Created by Ian Paul on 1-08-2021 20:34
import 'dart:io';

import "package:http/http.dart" as http;

class NetworkUtils{

  static Future<http.Response> createGetRequest(String url) async{
    //check internet connection here using (ex: connectivity plugin)

    http.Response response;
    Uri baseUrl = Uri.parse(url);
    try{
      response = await http.get(baseUrl);
    } catch(e){
      if(e is SocketException)
        response = http.Response("{ \"status\":\"Turn on your internet!\"}", 12029);
        else
        response = http.Response("{ \"status\":\"Something went wrong\"}", 400);

      print("something went wrong : $e");
    }
    return response;
  }
}