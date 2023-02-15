import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'article_api.g.dart';

@RestApi()
abstract class ArticleApi {
  @GET("/api/articles")
  Future getArticles(
    @Query('page') int? page,
    @Query('limit') int? limit, [
    @Query('tag') String? tag,
    @Query('search') String? seach,
  ]);

  @GET("/api/article/tags")
  Future getTags();

  factory ArticleApi(Dio dio, {String baseUrl}) = _ArticleApi;
}
