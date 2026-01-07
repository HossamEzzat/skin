import 'package:equatable/equatable.dart';
import '../../domain/entities/article_entity.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object?> get props => [];
}

class FetchArticlesRequested extends ArticleEvent {}

class SearchArticlesRequested extends ArticleEvent {
  final String query;
  const SearchArticlesRequested(this.query);

  @override
  List<Object> get props => [query];
}

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object?> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<ArticleEntity> articles;
  const ArticlesLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

class ArticleError extends ArticleState {
  final String message;
  const ArticleError(this.message);

  @override
  List<Object?> get props => [message];
}
