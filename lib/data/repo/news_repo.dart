import '../model/categories_News_model.dart';
import '../model/news_headlines_model.dart';

abstract class NewsRepo {
  Future<CategoriesNewsModel> getCategoryNews(
    String category,
  );
  Future<NewsHeadLinesModel> getNewsHeadlines(
    String category,
  );
}
