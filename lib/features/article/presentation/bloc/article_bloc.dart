import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/usecases/get_articles_usecase.dart';
import 'article_bloc_states.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticlesUseCase getArticlesUseCase;
  List<ArticleEntity> _allArticles = [];

  ArticleBloc({required this.getArticlesUseCase}) : super(ArticleInitial()) {
    on<FetchArticlesRequested>(_onFetchArticlesRequested);
    on<SearchArticlesRequested>(_onSearchArticlesRequested);
  }

  Future<void> _onFetchArticlesRequested(
    FetchArticlesRequested event,
    Emitter<ArticleState> emit,
  ) async {
    emit(ArticleLoading());
    final result = await getArticlesUseCase(NoParams());
    result.fold(
      (failure) => emit(const ArticleError('Failed to fetch articles')),
      (articles) {
        final shuffled = List<ArticleEntity>.from(articles)..shuffle();
        _allArticles = shuffled;
        emit(ArticlesLoaded(shuffled));
      },
    );
  }

  void _onSearchArticlesRequested(
    SearchArticlesRequested event,
    Emitter<ArticleState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(ArticlesLoaded(_allArticles));
    } else {
      final filtered = _allArticles
          .where(
            (article) =>
                article.title.toLowerCase().contains(
                  event.query.toLowerCase(),
                ) ||
                article.category.toLowerCase().contains(
                  event.query.toLowerCase(),
                ),
          )
          .toList();
      emit(ArticlesLoaded(filtered));
    }
  }
}
