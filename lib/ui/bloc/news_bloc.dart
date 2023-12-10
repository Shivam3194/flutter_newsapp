import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_newsapp/data/repo/news_repo_impl.dart';
import 'package:flutter_newsapp/ui/bloc/news_state.dart';

import '../../data/repo/news_repo.dart';
import 'news_event.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepo postRepo = NewsRepoImpl();
  NewsBloc() : super(const NewsState()) {
    on<NewsHeadlinesFetchEvent>(_newsHeadlinesFetchEvent);
    on<NewsCategoriesFetchEvent>(_newsCategoriesFetchEvent);
  }

  FutureOr<void> _newsHeadlinesFetchEvent(
      NewsHeadlinesFetchEvent event, Emitter<NewsState> emit) async {
    emit(state.copyWith(status: Status.initial));

    await postRepo.getNewsHeadlines(event.channelId).then((value) {
      emit(
        state.copyWith(
          status: Status.success,
          newsList: value,
          message: 'Success',
        ),
      );
    }).onError((error, stackTrace) {
      emit(
        state.copyWith(
          categoriesStatus: Status.failure,
          categoriesMessage: error.toString(),
        ),
      );
    });
  }

  FutureOr<void> _newsCategoriesFetchEvent(
      NewsCategoriesFetchEvent event, Emitter<NewsState> emit) async {
    emit(state.copyWith(status: Status.initial));

    await postRepo.getCategoryNews(event.category).then((value) {
      emit(state.copyWith(
        categoriesStatus: Status.success,
        categoryNewsList: value,
        categoriesMessage: 'Success',
      ));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
        categoriesStatus: Status.failure,
        categoriesMessage: error.toString(),
      ));
      emit(state.copyWith(
        categoriesMessage: error.toString(),
      ));
    });
  }
}
