import 'dart:convert';

import 'package:flutter_newsapp/data/model/news_headlines_model.dart';

import 'package:flutter_newsapp/data/model/categories_News_model.dart';
import 'package:http/http.dart' as http;
import 'news_repo.dart';

class NewsRepoImpl extends NewsRepo {
  @override
  Future<CategoriesNewsModel> getCategoryNews(
    String category,
  ) async {
    String newsUrl =
        'https://newsapi.org/v2/everything?q=$category&apiKey=8a5ec37e26f845dcb4c2b78463734448';
    final response = await http.get(Uri.parse(newsUrl));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  @override
  Future<NewsHeadLinesModel> getNewsHeadlines(
    String newsChannel,
  ) async {
    String newsUrl =
        'https://newsapi.org/v2/top-headlines?sources=$newsChannel&apiKey=8a5ec37e26f845dcb4c2b78463734448';
    final response = await http.get(Uri.parse(newsUrl));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadLinesModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}
