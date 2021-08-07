import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/api_response.dart';
import 'package:news/models/NewsForListing.dart';

class NewsService {
  static const String API_KEY = 'f96331be8ca34b80855e89bb563105f1';

  Future<APIResponse<List<NewsForListing>>> getNewsList(
      {String category, String field, String type, String query}) {
    if (type == "everything") {
      String everything =
          'https://newsapi.org/v2/everything?q=$query&sortBy=popularity&apiKey=';
      return result(everything + API_KEY);
    } else {
      String topHeadLing =
          'https://newsapi.org/v2/top-headlines?country=$field&category=$category&apiKey=';

      return result(topHeadLing + API_KEY);
    }
  }

  Future<APIResponse<List<NewsForListing>>> result(String url) {
    return http.get(Uri.parse(url)).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        final notes = <NewsForListing>[];

        for (var item in jsonData["articles"]) {
          notes.add(NewsForListing.fromJson(item));
        }

        return APIResponse<List<NewsForListing>>(data: notes);
      }
      return APIResponse<List<NewsForListing>>(
          error: true, errorMessage: 'An error occurred');
    }).catchError((error) => APIResponse<List<NewsForListing>>(
        error: true, errorMessage: error.toString()));
  }
}
