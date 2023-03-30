import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:jd_mobile/domain/entities/articles/article_entites.dart';
import 'package:jd_mobile/domain/entities/base_filter.dart';
import 'package:jd_mobile/domain/usecases/articles/get_articles.dart';
import 'package:jd_mobile/domain/usecases/articles/get_tags.dart';

import '../../../common/utils/state_enum.dart';

class ArticleProvider extends ChangeNotifier {
  ArticleProvider({required this.getArticles, this.getTags});

  final GetArticles getArticles;
  final GetTags? getTags;
  int page = 1;
  int limit = 10;
  String search = "";
  bool lastPage = false;
  var listArticles = <ArticlesEntities>[];
  var listArticlesHome = <ArticlesEntities>[];
  var articleFav = <ArticlesEntities>[];
  var tag = <String>[];
  String selectedByTag = "";
  String selectedByTagHome = "";
  String _errorMessage = "";
  TextEditingController searchCtrl = TextEditingController();
  int selectedIndexTagArticels = 0;
  int selectedIndexTagArticlesHome = 0;

  int get getSelectedIndexTagArticle => selectedIndexTagArticlesHome;

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

  Future<void> getArticle({bool isFromHome = false}) async {
    setRequestStateArticles(RequestState.Loading);
    final result = await getArticles(Tuple3(
        page,
        limit,
        BaseFilterEntity(
          tag: (isFromHome ? selectedByTagHome : selectedByTag).split(":")[0],
          keywords: (isFromHome ?null:search),
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
      if ((isFromHome ? selectedByTagHome : selectedByTag).isNotEmpty) {
        (isFromHome ? listArticlesHome : listArticles).clear();
        (isFromHome ? listArticlesHome : listArticles).addAll(articles);
        notifyListeners();
      }

      /* FOR SEARCH */
      if (search.isNotEmpty) {
        listArticles.clear();
        listArticles.addAll(articles);
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
      if (isFromHome && selectedByTagHome.isEmpty) {
        listArticlesHome.clear();
        listArticlesHome.addAll(articles);
        notifyListeners();
      } else {
        if (selectedByTag.isEmpty && search.isEmpty) {
          listArticles.clear();
          listArticles.addAll(articles);
          notifyListeners();
        }
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
      tag.clear();
      tag.add("Semua");
      notifyListeners();
      r.data.forEach((String item) {
        tag.add(item.split(":")[0]);
        notifyListeners();
      });
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

  void setSelectedByTagHome(value) {
    selectedByTagHome = value;
    notifyListeners();
  }

  void setPage(value) {
    page = value;
    notifyListeners();
  }

  void clearArticle({bool isFromHome = false}) {
    (isFromHome ? listArticlesHome : listArticles).clear();
    notifyListeners();
  }

  void setSearch(value) {
    search = value;
    notifyListeners();
  }

  void setSelectedIndexTagArticle(value) {
    selectedIndexTagArticels = value;
    notifyListeners();
  }

  setSelectedIndexTagArticleHome(int value) {
    selectedIndexTagArticlesHome = value;
    notifyListeners();
  }
}
