import "package:equatable/equatable.dart";
import "package:flutter_newsapp/data/model/news_headlines_model.dart";

import "../../data/model/categories_News_model.dart";

enum Status { initial, success, failure }

class NewsState extends Equatable {
  final Status status;
  final NewsHeadLinesModel? newsList;
  final String message;
  final String categoriesMessage;
  final Status categoriesStatus;
  final CategoriesNewsModel? categoryNewsList;

  const NewsState({
    this.status = Status.initial,
    this.newsList,
    this.message = '',
    this.categoriesStatus = Status.initial,
    this.categoryNewsList,
    this.categoriesMessage = '',
  });

  NewsState copyWith({
    Status? status,
    NewsHeadLinesModel? newsList,
    String? message,
    Status? categoriesStatus,
    CategoriesNewsModel? categoryNewsList,
    String? categoriesMessage,
  }) {
    return NewsState(
      status: status ?? this.status,
      newsList: newsList ?? this.newsList,
      message: message ?? this.message,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categoryNewsList: categoryNewsList ?? this.categoryNewsList,
      categoriesMessage: categoriesMessage ?? this.categoriesMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        newsList,
        message,
        categoriesStatus,
        categoryNewsList,
        categoriesMessage,
      ];
}

class NewsStateErrorState extends Equatable {
  final String message;

  const NewsStateErrorState({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
