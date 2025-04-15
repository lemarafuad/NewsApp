import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';
import 'package:news_app/config.dart';

class RemoteNewsService {
  static var client = http.Client();

  static Future<List<NewsArticle>?> fetchNewsArticles({
    String category = "general",
  }) async {
    var apiKey = Config.apiKey;
    try {
      var response = await client.get(
        Uri.parse(
          "https://newsapi.org/v2/top-headlines?category=$category&apiKey=$apiKey",
        ),
      );

      if (response.statusCode == 200) {
        return newsArticleFromJson(response.body);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print("Error fetching articles: $e");
      return null;
    }
  }
}
