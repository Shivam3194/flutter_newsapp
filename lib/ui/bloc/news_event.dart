import "package:equatable/equatable.dart";

abstract class NewsEvent extends Equatable {}

class NewsHeadlinesFetchEvent extends NewsEvent {
  final String channelId;

  NewsHeadlinesFetchEvent(this.channelId);

  @override
  List<Object?> get props => [channelId];
}

class NewsCategoriesFetchEvent extends NewsEvent {
  final String category;

  NewsCategoriesFetchEvent(this.category);
  @override
  List<Object?> get props => [category];
}
