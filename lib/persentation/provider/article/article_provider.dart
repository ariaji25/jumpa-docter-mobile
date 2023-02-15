import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:jd_mobile/domain/entities/articles/article_entites.dart';
import 'package:jd_mobile/domain/entities/base_filter.dart';
import 'package:jd_mobile/domain/usecases/articles/get_articles.dart';
import 'package:jd_mobile/domain/usecases/articles/get_tags.dart';

import '../../../common/utils/state_enum.dart';

class ArticleProvider extends ChangeNotifier {
  ArticleProvider({this.getArticles, this.getTags});

  final GetArticles? getArticles;
  final GetTags? getTags;
  int page = 1;
  int limit = 10;
  String search = "";
  bool lastPage = false;
  var article = <ArticlesEntities>[];
  var articleFav = <ArticlesEntities>[];
  var tag = <String>[];
  String selectedByTag = "";
  String _errorMessage = "";
  TextEditingController searchCtrl = TextEditingController();
  int selectedIndex = 0;

  String get errorMessage => _errorMessage;
  RequestState _requestStateArticles = RequestState.Loading;
  RequestState _requestStateArticleTags = RequestState.Loading;

  RequestState get requestStateArticles => _requestStateArticles;

  void setRequestStateArticles(RequestState state) {
    _requestStateArticles = state;
    notifyListeners();
  }

  RequestState get requestStateArticleTags => _requestStateArticleTags;

  void setRequestStateArticleTags(RequestState state) {
    _requestStateArticleTags = state;
    notifyListeners();
  }

  Future<void> getArticle() async {
    setRequestStateArticles(RequestState.Loading);
    final result = await getArticles!(Tuple3(
        page,
        limit,
        BaseFilterEntity(
          tag: selectedByTag.split(":")[0],
          keywords: search,
        )));
    result.fold((l) {
      setRequestStateArticles(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (articles) async {
      if (articles.isEmpty) {
        lastPage = true;
        notifyListeners();
      }

      /* FOR SELECT BY TAG */
      if (selectedByTag.isNotEmpty) {
        article.clear();
        article.addAll(articles);
        notifyListeners();
      }

      /* FOR SEARCH */
      if (search.isNotEmpty) {
        article.clear();
        article.addAll(articles);
        notifyListeners();
      }

      /* FOR ARTICLE FAVORITE */
      if (articleFav.isEmpty) {
        for (var i = 0; i < 2; i++) {
          articleFav.add(articles[i]);
          notifyListeners();
        }
        notifyListeners();
      }

      /* FOR GET ALL */
      if (selectedByTag.isEmpty && search.isEmpty) {
        article.addAll(articles);
        notifyListeners();
      }
      setRequestStateArticles(RequestState.Loaded);
    });
  }

  Future getTag() async {
    setRequestStateArticleTags(RequestState.Loading);
    final result = await getTags!();
    result.fold((l) {
      setRequestStateArticleTags(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (r) async {
      tag.add("Semua");
      notifyListeners();
      tag.addAll(r ?? <String>[]);
      notifyListeners();
      setRequestStateArticleTags(RequestState.Loaded);
    });
  }

  void changePaginationFilter(int pageVal, int limitVal) {
    page = pageVal;
    notifyListeners();
    limit = limitVal;
    notifyListeners();
  }

  void loadNextPage() {
    changePaginationFilter(page + 1, limit);
  }

  void setSelectedByTag(value) {
    selectedByTag = value;
    notifyListeners();
  }

  void setPage(value) {
    page = value;
    notifyListeners();
  }

  void clearArticle() {
    article.clear();
    notifyListeners();
  }

  void setSearch(value) {
    search = value;
    notifyListeners();
  }

  void setSelectedIndex(value) {
    selectedIndex = value;
    notifyListeners();
  }
}
