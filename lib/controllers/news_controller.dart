import 'package:get/get.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/remote_service.dart';

class NewsController extends GetxController {
  var newsArticles = <NewsArticle>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void fetchArticles({String category = "general"}) async {
    try {
      isLoading(true);
      var articles = await RemoteNewsService.fetchNewsArticles(
        category: category,
      );
      if (articles != null) {
        newsArticles(articles);
      }
    } finally {
      isLoading(false);
    }
  }
}
