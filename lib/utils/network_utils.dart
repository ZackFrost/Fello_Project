///Created by Ian Paul on 1-08-2021 20:34
import "package:http/http.dart" as http;

class NetworkUtils{

  static Future<http.Response> createGetRequest(String url) async{
    //check internet connection here

    http.Response response;
    Uri baseUrl = Uri.parse(url);
    try{
      response = await http.get(baseUrl);
    } catch(e){
      response = http.Response("{ \"status\":\"error\"}", 400);
      print("something went wrong : $e");
    }
    return response;
  }
}